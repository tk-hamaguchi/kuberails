# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::AdapterConfigurationError do
  subject(:described_instance) { described_class.new params }

  let(:params) { 'hoge' }

  context '#to_s' do
    subject { described_instance.to_s }

    it { is_expected.to eq 'Unknown adapter type hoge' }
  end

  context '#inspect' do
    subject { described_instance.inspect }

    it { is_expected.to eq '#<Kuberails::AdapterConfigurationError: Unknown adapter type hoge>' }
  end

  context '#message' do
    subject { described_instance.message }

    it { is_expected.to eq 'Unknown adapter type hoge' }
  end

  context '@adapter' do
    subject(:instance_variable_adapter) { described_instance.instance_variable_get :@adapter }

    it { is_expected.to eq params }
  end
end
