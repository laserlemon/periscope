require 'spec_helper'

module Periscope
  describe BlackList do
    it_should_behave_like 'a permission set'
    it_should_behave_like 'a sanitizer'

    let(:values){ %w(one two three) }
    subject{ described_class.new(values) }

    it 'denies an included value' do
      subject.deny?(values.first).should == true
    end

    it 'accepts an excluded value' do
      subject.deny?('four').should == false
    end
  end
end
