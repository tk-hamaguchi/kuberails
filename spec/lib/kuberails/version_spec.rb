# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails do
  context 'VERSION' do
    subject { described_class.const_get(:VERSION) }

    it { is_expected.to eq '0.1.0' }
    it { expect(described_class::VERSION).to eq '0.1.0' }
  end
end
