# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails do
  subject(:included_module) { described_class }

  it { is_expected.to respond_to :configuration }
  it { is_expected.to respond_to :reset }
  it { is_expected.to respond_to :configure }

  it { is_expected.to respond_to :logger }
  it { is_expected.to respond_to :logger= }
end
