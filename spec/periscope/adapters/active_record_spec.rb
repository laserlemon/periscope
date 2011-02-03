require 'spec_helper'

module Periscope
  module Adapters
    describe ActiveRecord do
      it_should_behave_like 'an adapter'

      describe :periscope do
        subject do
          Class.new(User).tap do |klass|
            klass.class_eval do
              scope :gender, lambda{|g| where(:gender => g) }
              scope :makes, lambda{|s| where('users.salary >= ?', s) }
              scope :rich, where('users.salary >= 1000000')
            end
          end
        end

        context 'ignores' do
          specify 'all scopes by default' do
            subject.should_receive(:gender).never
            subject.should_receive(:makes).never

            subject.periscope(:gender => 'male', :makes => 100000)
          end

          specify 'all scopes when none are accessible' do
            subject.scope_accessible

            subject.should_receive(:gender).never
            subject.should_receive(:makes).never

            subject.periscope(:gender => 'male', :makes => 100000)
          end

          specify 'protected scopes' do
            subject.scope_protected :makes

            subject.should_receive(:gender).with('male').once
            subject.should_receive(:makes).never

            subject.periscope(:gender => 'male', :makes => 100000)
          end
        end

        context 'uses' do
          specify 'all scopes when none are protected' do
            subject.scope_protected

            subject.should_receive(:gender).with('male').once
            subject.should_receive(:makes).with(100000).once

            subject.periscope(:gender => 'male', :makes => 100000)
          end

          specify 'accessible scopes' do
            subject.scope_accessible :gender

            subject.should_receive(:gender).with('male').once
            subject.should_receive(:makes).never

            subject.periscope(:gender => 'male', :makes => 100000)
          end

          specify 'accessible, zero-arity scopes' do
            subject.scope_accessible :rich

            subject.should_receive(:rich).with(true).once

            lambda{ subject.periscope(:rich => true) }.should_not raise_error
          end
        end

        context 'returns' do
          before do
            subject.delete_all
            subject.create(:name => 'Henry', :gender => 'male', :salary => 50_000)
            subject.create(:name => 'Penny', :gender => 'female', :salary => 1_000_000)
            subject.create(:name => 'Sammy', :gender => 'male', :salary => 100_000)
          end

          let(:params){ {:gender => 'male', :rich => true} }

          context 'all records' do
            specify 'for no params' do
              subject.periscope.map(&:name).should == %w(Henry Penny Sammy)
            end

            specify 'for empty params' do
              subject.periscope({}).map(&:name).should == %w(Henry Penny Sammy)
            end

            specify 'for no accessible scopes' do
              subject.scope_accessible

              subject.periscope(params).map(&:name).should == %w(Henry Penny Sammy)
            end

            specify 'for all protected scopes' do
              subject.scope_protected :gender, :rich

              subject.periscope(params).map(&:name).should == %w(Henry Penny Sammy)
            end
          end

          context 'scoped results' do
            specify 'for an accessible scope' do
              subject.scope_accessible :rich

              subject.periscope(params).map(&:name).should == %w(Penny)
            end

            specify 'for an unprotected scope' do
              subject.scope_protected :gender

              subject.periscope(params).map(&:name).should == %w(Penny)
            end

            specify 'for multiple accessible scopes' do
              subject.scope_accessible :gender, :rich

              subject.periscope(params).should be_empty
            end
          end
        end
      end
    end
  end
end
