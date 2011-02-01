require 'spec_helper'
require 'active_support/core_ext/hash/slice'

class FakeSanitizer
  include Periscope::Sanitizer
end

class FakeLogger
  def debug(message)
    output << message
  end

  def output
    @output ||= []
  end
end

module Periscope
  describe Sanitizer, 'included in' do
    describe FakeSanitizer do
      subject{ FakeSanitizer.new }

      let(:logger){ FakeLogger.new }
      let(:params){ {:one => 1, :two => 2} }

      it 'has its own logger' do
        logger.should_receive(:debug).once

        subject.logger = logger
        subject.logger.should == logger

        subject.logger.debug
      end

      it 'removes denied keys from a hash' do
        subject.stub(:deny?).with(:one).and_return(false)
        subject.stub(:deny?).with(:two).and_return(true)
        subject.sanitize(params).should == params.slice(:one)
      end

      it "doesn't remove keys if none are denied" do
        subject.stub(:deny? => false)
        subject.sanitize(params).should == params
      end

      it 'debugs removed keys' do
        subject.logger = logger
        subject.logger.should_receive(:debug).once

        subject.stub(:deny? => true)
        subject.sanitize(params)
      end

      it "doesn't debug if there's no logger" do
        subject.logger.should be_nil

        allow_message_expectations_on_nil
        subject.logger.should_receive(:debug).never

        subject.stub(:deny? => true)
        subject.sanitize(params)
      end

      it "doesn't debug if no keys are removed" do
        subject.logger = logger
        subject.logger.should_receive(:debug).never

        subject.stub(:deny? => false)
        subject.sanitize(params)
      end

      it 'only debugs the removed keys' do
        subject.logger = logger

        subject.stub(:deny?).with(:one).and_return(false)
        subject.stub(:deny?).with(:two).and_return(true)
        subject.sanitize(params)

        message = subject.logger.output.pop
        message.should_not match(/\bone\b/)
        message.should match(/\btwo\b/)
      end
    end
  end
end
