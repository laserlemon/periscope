# Periscope

[![Gem Version](https://img.shields.io/gem/v/periscope.svg?style=flat)](http://rubygems.org/gems/periscope)
[![Build Status](https://img.shields.io/travis/laserlemon/periscope/master.svg?style=flat)](https://travis-ci.org/laserlemon/periscope)
[![Code Climate](https://img.shields.io/codeclimate/github/laserlemon/periscope.svg?style=flat)](https://codeclimate.com/github/laserlemon/periscope)
[![Coverage Status](https://img.shields.io/codeclimate/coverage/github/laserlemon/periscope.svg?style=flat)](https://codeclimate.com/github/laserlemon/periscope)
[![Dependency Status](https://img.shields.io/gemnasium/laserlemon/periscope.svg?style=flat)](https://gemnasium.com/laserlemon/periscope)

Periscope provides a simple way to chain scopes on your models and to open those scopes up to your users.

## Installation

Periscope sits on top of your favorite ORM. Currently, the following ORMs are supported through individual gems extending Periscope:

* Active Record ([periscope-activerecord](https://rubygems.org/gems/periscope-activerecord))
* MongoMapper ([periscope-mongo_mapper](https://rubygems.org/gems/periscope-mongo_mapper))
* Mongoid ([periscope-mongoid](https://rubygems.org/gems/periscope-mongoid))
* DataMapper ([periscope-data_mapper](https://rubygems.org/gems/periscope-data_mapper))

Simply add the gem to your bundle and you're off!

## The Problem

More often than not, the index action in a RESTful Rails controller is expected to do a lot more than simply return all the records for a given model. We ask it to do all sorts of stuff like filtering, sorting and paginating results. Of course, this is typically done using _scopes_.

But it can get ugly building long, complicated chains of scopes in the controller, especially when you try to give your users control over the scoping. Picture this:

```ruby
def index
  @articles = Article.scoped
  @articles = @articles.published_after(params[:published_after]) if params.key?(:published_after)
  @articles = @articles.published_before(params[:published_before]) if params.key?(:published_before)
end
```

You can imagine how bad this would get if more than two scopes were involved.

## The Solution

With Periscope, you can have this instead:

```ruby
def index
  @articles = Article.periscope(request.query_parameters)
end
```

The `periscope` method will find keys in your params matching your scope names and chain your scopes for you.

**Note:** We're using `request.query_parameters` so that we can exclude our controller and action params. `request.query_parameters` will just return the params that appear in the query string.

## But Wait!

"What if I don't want to make all my scopes publicly accessible?"

Within your model you can use the `scope_accessible` method to specify which scopes you want Periscope to honor.

```ruby
class User < ActiveRecord::Base
  scope :gender, proc { |g| where(gender: g) }
  scope :makes, proc { |s| where("salary >= ?", s) }

  scope_accessible :gender
end
```

And in your controller:

```ruby
class UsersController < ApplicationController
  def index
    @users = User.periscope(request.query_parameters)
  end
end
```

Requests to `/users?gender=male` will filter results to only male users. But a request to `/users?makes=1000000` will return all users, silently ignoring the protected scope.

By default, all scopes are protected.

## There's More!

### Custom Parameter Parsing

Sometimes the values you get from the query parameters aren't quite good enough. They may need to be massaged in order to work with your scopes and class methods. In those cases, you can provide a `:parser` option to your `scope_accessible` method.

Parsers must respond to the `call` method, receiving the raw query parameter and returning an array of arguments to pass to the scope or class method.

```ruby
class User < ActiveRecord::Base
  scope :gender, proc { |g| where(gender: g) }

  scope_accessible :gender, parser: proc { |g| [g.downcase] }
end
```

### On/Off Scopes

But not all scopes accept arguments. For scopes that you want to toggle on or off, you can set a `:boolean => true` option. Whenever the received parameter is truthy, the scope will be applied. Otherwise, it will be skipped.

```ruby
class User < ActiveRecord::Base
  scope :male, proc { where(gender: "male") }
  scope :female, proc { where(gender: "female") }

  scope_accessible :male, :female, boolean: true
end
```

### Custom Method Names

Sometimes the query parameters you want to open up to your users may collide with existing method names or reserved Ruby words. In order to avoid collision, you can set a `:method` option to specify what method to use for a query parameter.

```ruby
class Project < ActiveRecord::Base
  scope_accessible :begin, method: :begins_after
  scope_accessible :end, method: :ends_before

  def self.begins_after(date)
    where("begins_at >= ?", date)
  end

  def self.ends_before(date)
    where("ends_at <= ?", date)
  end
end
```

Alternatively, you can set `:prefix` and/or `:suffix` options, which will be applied to the query parameter name to determine the corresponding method name.

```ruby
class Project < ActiveRecord::Base
  scope_accessible :begin, :end, suffix: "_date"

  def self.begin_date(date)
    where("begins_at >= ?", date)
  end

  def self.end_date(date)
    where("ends_at <= ?", date)
  end
end
```

## This sucks.

How can I make it better?

1. Fork it.
2. Make it better.
3. Send me a pull request.
