# Periscope [![Build Status](https://secure.travis-ci.org/laserlemon/periscope.png)](http://travis-ci.org/laserlemon/periscope) [![Dependency Status](https://gemnasium.com/laserlemon/periscope.png)](https://gemnasium.com/laserlemon/periscope)

Periscope provides a simple way to chain scopes on your models and to open those scopes up to your users.

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
  attr_accessible :name, :gender, :salary

  scope :gender, lambda{|g| where(:gender => g) }
  scope :makes_more_than, lambda{|s| where('users.salary >= ?', s.to_i) }

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

Requests to `/users?gender=male` will filter results to only male users. But a request to `/users?makes_more_than=1000000` will return all users, silently ignoring the protected scope.

By default, all scopes are protected.

## This sucks. How can I make it better?

1. Fork it.
2. Make it better.
3. Send me a pull request.
