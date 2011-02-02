require 'spec_helper'

module Periscope
  describe WhiteList do
    it_should_behave_like 'a permission set'
    it_should_behave_like 'a sanitizer'

    let(:values){ %w(one two three) }
    subject{ described_class.new(values) }

    it 'accepts an included value' do
      subject.deny?(values.first).should == false
    end

    it 'denies an excluded value' do
      subject.deny?('four').should == true
    end
  end
end
