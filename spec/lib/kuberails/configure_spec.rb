# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::Configure do
  subject(:included_module) { Module.new { include Kuberails::Configure } }

  let(:configuration) { instance_double(Kuberails::Configuration, 'k8s_url=' => true) }

  before do
    allow(Kuberails::Configuration).to receive(:new).and_return(configuration)
  end

  it { is_expected.to respond_to :configuration }
  it { is_expected.to respond_to :reset }
  it { is_expected.to respond_to :configure }

  context '@configuration' do
    subject(:@configuration) { included_module.instance_variable_get :@configuration }

    it { is_expected.to be_nil }
  end

  context '.configuration' do
    subject(:exec_configuration) { included_module.configuration }

    it { is_expected.to eq configuration }

    context '@configuration' do
      subject(:@configuration) { included_module.instance_variable_get :@configuration }

      before { exec_configuration }

      it { is_expected.to eq configuration }
    end

    context 'Kuberails::Configuration' do
      before { exec_configuration }

      it { expect(Kuberails::Configuration).to have_received(:new).with(no_args).once }
    end
  end

  context '.reset' do
    subject(:exec_reset) { included_module.reset }

    it { is_expected.to eq configuration }

    context '@configuration' do
      subject(:@configuration) { included_module.instance_variable_get :@configuration }

      before { exec_reset }

      it { is_expected.to eq configuration }
    end

    context 'Kuberails::Configuration' do
      before { exec_reset }

      it { expect(Kuberails::Configuration).to have_received(:new).with(no_args).once }
    end
  end

  context '.configure' do
    subject(:exec_configure) { included_module.configure { |config| config.k8s_url = :fuga } }

    context 'Kuberails::Configuration' do
      before { exec_configure }

      it { expect(Kuberails::Configuration).to have_received(:new).with(no_args).once }
      it { expect(configuration).to have_received(:k8s_url=).with(:fuga).once }
    end
  end
end
