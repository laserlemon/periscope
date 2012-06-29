shared_examples 'databasic' do
  context 'with a database' do
    before do
      create(:user, :gender => 'male', :salary => 1_000_000)
      create(:user, :gender => 'female', :salary => 2_000_000)
      create(:user, :gender => 'female', :salary => 3_000_000)
    end

    it 'returns all records for no params' do
      User.periscope.count.should == 3
    end

    it 'respects existing scoping' do
      User.female.periscope.count.should == 2
    end

    it 'links to existing scoping' do
      User.scope_accessible(:makes)
      User.female.periscope(:makes => 3_000_000).count.should == 1
    end

    it 'applies named scopes' do
      User.scope_accessible(:male, :boolean => true)
      User.periscope(:male => true).count.should == 1
    end

    it 'applies class methods' do
      User.scope_accessible(:gender)
      User.periscope(:gender => 'male').count.should == 1
    end

    it 'chains scopes' do
      User.scope_accessible(:gender, :makes)
      User.periscope(:gender => 'female', :makes => 3_000_000).count.should == 1
    end
  end
end
