shared_examples_for 'an adapter' do
  subject do
    Class.new.tap do |klass|
      klass.send(:include, described_class)
    end
  end

  it 'adds accessible scopes' do
    subject.scope_accessible :current, :expired

    subject.accessible_scopes.should include(:current)
    subject.accessible_scopes.should include(:expired)
  end

  it 'adds protected scopes' do
    subject.scope_protected :current, :expired

    subject.protected_scopes.should include(:current)
    subject.protected_scopes.should include(:expired)
  end

  it 'stacks accessible scopes' do
    subject.scope_accessible :current
    subject.scope_accessible :expired

    subject.accessible_scopes.should include(:current)
    subject.accessible_scopes.should include(:expired)
  end

  it 'stacks protected scopes' do
    subject.scope_protected :current
    subject.scope_protected :expired

    subject.protected_scopes.should include(:current)
    subject.protected_scopes.should include(:expired)
  end

  it 'uses accessible scopes if defined last' do
    subject.scope_protected :current
    subject.scope_accessible :expired

    subject.periscope_authorizer.should be_a(Periscope::WhiteList)
    subject.periscope_authorizer.should == subject.accessible_scopes
  end

  it 'uses protected scopes if defined last' do
    subject.scope_accessible :current
    subject.scope_protected :expired

    subject.periscope_authorizer.should be_a(Periscope::BlackList)
    subject.periscope_authorizer.should == subject.protected_scopes
  end

  it 'defaults to using accessible scopes' do
    subject.periscope_authorizer.should be_a(Periscope::WhiteList)
    subject.periscope_authorizer.should == subject.accessible_scopes
  end

  it 'has no accesible scopes by default' do
    subject.accessible_scopes.should be_empty
  end

  it 'has no protected scopes by default' do
    subject.protected_scopes.should be_empty
  end

  it 'can override the default accessible scopes' do
    subject.class_eval do
      def self.scopes_accessible_by_default
        [:current]
      end
    end

    subject.accessible_scopes.should include(:current)
  end

  it 'makes its authorizer available to its instances' do
    subject.scope_accessible :current

    subject.new.send(:search_authorizer).should == subject.accessible_scopes
  end

  it 'sanitizes params from its instances' do
    params = {:current => 'yes', :expired => 'no'}
    subject.scope_accessible :current

    subject.new.send(:sanitize_for_search, params).should == params.slice(:current)
  end
end
