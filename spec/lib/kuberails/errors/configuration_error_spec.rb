# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::ConfigurationError do
  subject(:described_instance) { described_class.new params }

  let(:params) { 'hoge' }

  context '#to_s' do
    subject { described_instance.to_s }

    it { is_expected.to eq 'hoge' }
  end

  context '#inspect' do
    subject { described_instance.inspect }

    it { is_expected.to eq '#<Kuberails::ConfigurationError: hoge>' }
  end

  context '#message' do
    subject { described_instance.message }

    it { is_expected.to eq 'hoge' }
  end

end
