require 'spec_helper'

module Periscope
  module Adapters
    describe ActiveRecord do
      it_should_behave_like 'an adapter'

      subject do
        Class.new(User).tap do |klass|
          klass.class_eval do
            scope :gender, lambda{|g| where(:gender => g) }
            scope :makes, lambda{|s| where('users.salary >= ?', s) }
            scope :rich, where('users.salary >= 1000000')
          end
        end
      end

      it 'ignores all scopes by default' do
        subject.should_receive(:gender).never
        subject.should_receive(:makes).never

        subject.periscope(:gender => 'male', :makes => 100000)
      end

      it 'ignores all scopes when none are accessible' do
        subject.scope_accessible

        subject.should_receive(:gender).never
        subject.should_receive(:makes).never

        subject.periscope(:gender => 'male', :makes => 100000)
      end

      it 'uses all scopes when none are protected' do
        subject.scope_protected

        subject.should_receive(:gender).with('male').once
        subject.should_receive(:makes).with(100000).once

        subject.periscope(:gender => 'male', :makes => 100000)
      end

      it 'uses accessible scopes' do
        subject.scope_accessible :gender

        subject.should_receive(:gender).with('male').once
        subject.should_receive(:makes).never

        subject.periscope(:gender => 'male', :makes => 100000)
      end

      it 'ignores protected scopes' do
        subject.scope_protected :makes

        subject.should_receive(:gender).with('male').once
        subject.should_receive(:makes).never

        subject.periscope(:gender => 'male', :makes => 100000)
      end

      it 'uses accessible, zero-arity scopes' do
        subject.scope_accessible :rich

        subject.should_receive(:rich).with(true).once

        lambda{ subject.periscope(:rich => true) }.should_not raise_error
      end
    end
  end
end
