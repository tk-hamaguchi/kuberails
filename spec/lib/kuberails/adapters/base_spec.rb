# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::Adapters::Base do
  subject { described_class }

  %i[create_deployment create_service create_ingress
     list_ingresses list_services list_deployments list_replica_sets list_pods destroy_ingresses
     destroy_services destroy_deployments destroy_replica_sets destroy_pods].each do |method_name|
    it { is_expected.to respond_to method_name }
    context ".#{method_name}" do
      subject(method_name) { super().send(method_name, 'hoge') }

      it { expect { send(method_name) }.to raise_error NotImplementedError }
    end
  end
end
