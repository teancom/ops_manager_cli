require 'spec_helper'
require 'ops_manager_deployer/logging'

describe OpsManagerDeployer::Logging do
  class Foo
    include OpsManagerDeployer::Logging
  end

  describe 'Foo#logger' do
    let(:foo){ Foo.new }

    it 'should be kind of Logger' do
      expect(foo.logger).to be_kind_of(Logger)
    end

    it 'should always return the same instance' do
      expect(foo.logger).to eq(foo.logger)
    end

    it 'should output logs to a file' do
      OpsManagerDeployer::Logging.logger=nil
      expect(Logger).to receive(:new).with('ops_manager_deployer.log')
      OpsManagerDeployer::Logging.logger
    end

    describe 'when DEBUG=true' do
      before { ENV['DEBUG']= 'true' }

      it 'should output logs to a file' do
        OpsManagerDeployer::Logging.logger=nil
        expect(Logger).to receive(:new).with(STDOUT)
        OpsManagerDeployer::Logging.logger
      end

      after{ ENV.delete('DEBUG') }
    end
  end
end
