require 'spec_helper'

describe Periscope do
  let(:model) do
    klass = mock.as_null_object
    klass.extend(Periscope)
    klass.stub(:periscope_default_scope => klass)
    klass
  end

  def expect_scopes(hash)
    hash.each do |scope, value|
      model.should_receive(scope).once.with(value).and_return(model)
    end
  end

  it 'uses the default scope for no params' do
    scoped = mock.as_null_object
    model.should_receive(:periscope_default_scope).once.and_return(scoped)
    model.periscope.should == scoped
  end

  it 'uses the default scope for empty params' do
    scoped = mock.as_null_object
    model.should_receive(:periscope_default_scope).once.and_return(scoped)
    model.periscope({}).should == scoped
  end

  it 'ignores protected scopes' do
    model.should_not_receive(:foo)
    model.periscope(:foo => 'bar')
  end

  it 'calls accessible scopes with values' do
    expect_scopes(:foo => 'bar')
    model.scope_accessible(:foo)
    model.periscope(:foo => 'bar')
  end

  it 'recognizes accessible scopes, whether string or symbol' do
    expect_scopes(:foo => 'baz', :bar => 'mitzvah')
    model.scope_accessible(:foo, 'bar')
    model.periscope('foo' => 'baz', :bar => 'mitzvah')
  end

  it 'prefixes method names in order to avoid collisions' do
    expect_scopes(:scope_for_begin => '1983-05-28', :scope_for_end => '2083-05-28')
    model.scope_accessible(:begin, :end, :prefix => :scope_for)
    model.periscope(:begin => '1983-05-28', :end => '2083-05-28')
  end

  it 'suffixes method names in order to avoid collisions' do
    expect_scopes(:begin_scope => '1983-05-28', :end_scope => '2083-05-28')
    model.scope_accessible(:begin, :end, :suffix => :scope)
    model.periscope(:begin => '1983-05-28', :end => '2083-05-28')
  end
end
