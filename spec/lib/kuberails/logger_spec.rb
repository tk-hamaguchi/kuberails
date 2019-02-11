# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::Logger do
  subject(:included_module) { Module.new { include Kuberails::Logger } }

  let(:rails_logger) { instance_double(ActiveSupport::Logger) }

  before do
    allow(Rails).to receive(:logger).and_return(rails_logger)
  end

  it { is_expected.to respond_to :logger }

  context '@logger' do
    subject(:@logger) { included_module.instance_variable_get :@logger }

    it { is_expected.to be_nil }
  end

  context '.logger' do
    subject(:exec_logger) { included_module.logger }

    it { is_expected.to eq rails_logger }

    context '@logger' do
      subject(:@logger) { included_module.instance_variable_get :@logger }

      before { exec_logger }

      it { is_expected.to eq rails_logger }
    end

    context 'Rails' do
      before { exec_logger }

      it { expect(Rails).to have_received(:logger).with(no_args).once }
    end
  end

  context '.logger=' do
    subject(:exec_logger) { included_module.logger = mock_logger }

    let(:mock_logger) { instance_double(::Logger) }

    it { is_expected.to eq mock_logger }

    context '@logger' do
      subject(:@logger) { included_module.instance_variable_get :@logger }

      before { exec_logger }

      it { is_expected.to eq mock_logger }
    end
  end
end
