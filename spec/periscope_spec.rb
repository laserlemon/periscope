require 'spec_helper'

describe Periscope do
  let(:model) do
    klass = mock.as_null_object
    klass.extend(Periscope)
    klass.stub(:periscope_default_scope => klass)
    klass
  end

  def expect_scopes(hash)
    hash.each do |scope, values|
      model.should_receive(scope).once.with(*values).and_return(model)
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
    expect_scopes(:foo => ['bar'])
    model.scope_accessible(:foo)
    model.periscope(:foo => 'bar')
  end

  it 'recognizes accessible scopes, whether string or symbol' do
    expect_scopes(:foo => ['baz'], :bar => ['mitzvah'])
    model.scope_accessible(:foo, 'bar')
    model.periscope('foo' => 'baz', :bar => 'mitzvah')
  end

  it 'ignores protected scopes when mixed with accessible scopes' do
    expect_scopes(:foo => ['baz'])
    model.should_not_receive(:bar)
    model.scope_accessible(:foo)
    model.periscope(:foo => 'baz', :bar => 'mitzvah')
  end

  it 'prefixes method names in order to avoid collisions' do
    expect_scopes(:scope_for_begin => ['1983-05-28'], :scope_for_end => ['2083-05-28'])
    model.scope_accessible(:begin, :end, :prefix => :scope_for)
    model.periscope(:begin => '1983-05-28', :end => '2083-05-28')
  end

  it 'suffixes method names in order to avoid collisions' do
    expect_scopes(:begin_scope => ['1983-05-28'], :end_scope => ['2083-05-28'])
    model.scope_accessible(:begin, :end, :suffix => :scope)
    model.periscope(:begin => '1983-05-28', :end => '2083-05-28')
  end

  it 'prefixes and suffixes method names' do
    expect_scopes(:foo_begin_bar => ['1983-05-28'], :foo_end_bar => ['2083-05-28'])
    model.scope_accessible(:begin, :end, :prefix => :foo, :suffix => :bar)
    model.periscope(:begin => '1983-05-28', :end => '2083-05-28')
  end

  it 'allows multiple scope_accessible calls' do
    expect_scopes(:foo => ['baz'], :bar => ['mitzvah'])
    model.scope_accessible(:foo)
    model.scope_accessible(:bar)
    model.periscope(:foo => 'baz', :bar => 'mitzvah')
  end

  it 'overrides scope_accessible options per call' do
    expect_scopes(:start => ['1983-05-28'], :end_scope => ['2083-05-28'])
    model.scope_accessible(:start, :end, :suffix => :scope)
    model.scope_accessible(:start)
    model.periscope(:start => '1983-05-28', :end => '2083-05-28')
  end

  it 'allows custom parameter parsing via proc' do
    expect_scopes(:foo => ['BAR'])
    model.scope_accessible(:foo, :parser => proc{|p| [p.upcase] })
    model.periscope(:foo => 'bar')
  end

  it 'allows custom parameter parsing via custom parser' do
    parser = mock.as_null_object
    parser.should_receive(:call).once.with('bar').and_return(['BAR'])
    expect_scopes(:foo => ['BAR'])
    model.scope_accessible(:foo, :parser => parser)
    model.periscope(:foo => 'bar')
  end

  it 'allows parameter exclusion for argument-less scopes' do
    expect_scopes(:foo => [])
    model.scope_accessible(:foo, :boolean => true)
    model.periscope(:foo => 'bar')
  end

  it 'allows accessible scope exclusion given a falsey param' do
    model.should_not_receive(:foo)
    model.scope_accessible(:foo, :boolean => true)
    model.periscope(:foo => nil)
  end

  it 'allows accessible scope exclusion given a falsey parsed value' do
    model.should_not_receive(:foo)
    model.scope_accessible(:foo, :boolean => true, :parser => proc{ [nil] })
    model.periscope(:foo => 'bar')
  end

  it 'passes along a nil param' do
    expect_scopes(:foo => [nil])
    model.scope_accessible(:foo)
    model.periscope(:foo => nil)
  end

  it 'passes along a nil parsed value' do
    expect_scopes(:foo => [nil])
    model.scope_accessible(:foo, :parser => proc{ [nil] })
    model.periscope(:foo => 'bar')
  end
end
