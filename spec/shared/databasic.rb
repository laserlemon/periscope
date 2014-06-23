shared_examples "databasic" do
  context "with a database" do
    before do
      create(:user, gender: "male", salary: 1_000_000)
      create(:user, gender: "female", salary: 2_000_000)
      create(:user, gender: "female", salary: 3_000_000)
    end

    it "returns all records for no params" do
      expect(User.periscope.count).to eq(3)
    end

    it "respects existing scoping" do
      expect(User.female.periscope.count).to eq(2)
    end

    it "links to existing scoping" do
      User.scope_accessible(:makes)
      expect(User.female.periscope(makes: 3_000_000).count).to eq(1)
    end

    it "applies named scopes" do
      User.scope_accessible(:male, boolean: true)
      expect(User.periscope(male: true).count).to eq(1)
    end

    it "applies class methods" do
      User.scope_accessible(:gender)
      expect(User.periscope(gender: "male").count).to eq(1)
    end

    it "chains scopes" do
      User.scope_accessible(:gender, :makes)
      expect(User.periscope(gender: "female", makes: 3_000_000).count).to eq(1)
    end
  end
end
