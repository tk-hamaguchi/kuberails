# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::Adapters::Base do
  subject { described_class }

  it { is_expected.to respond_to :create_deployment }
  it { is_expected.to respond_to :create_service }
  it { is_expected.to respond_to :create_ingress }
  it { is_expected.to respond_to :list_ingresses }
  it { is_expected.to respond_to :list_services }
  it { is_expected.to respond_to :list_deployments }
  it { is_expected.to respond_to :list_replica_sets }
  it { is_expected.to respond_to :list_pods }
  it { is_expected.to respond_to :delete_ingresses }
  it { is_expected.to respond_to :delete_services }
  it { is_expected.to respond_to :delete_deployments }
  it { is_expected.to respond_to :delete_replica_sets }
  it { is_expected.to respond_to :delete_pods }

  context '.create_deployment' do
    subject(:exec_create_deployment) { described_class.create_deployment('hoge') }

    it { expect { exec_create_deployment }.to raise_error NotImplementedError }
  end

  context '.create_service' do
    subject(:exec_create_service) { described_class.create_service('hoge') }

    it { expect { exec_create_service }.to raise_error NotImplementedError }
  end

  context '.create_ingress' do
    subject(:exec_create_ingress) { described_class.create_ingress('hoge') }

    it { expect { exec_create_ingress }.to raise_error NotImplementedError }
  end

  context '.list_ingresses' do
    subject(:exec_list_ingresses) { described_class.list_ingresses('hoge') }

    it { expect { exec_list_ingresses }.to raise_error NotImplementedError }
  end

  context '.list_services' do
    subject(:exec_list_services) { described_class.list_services('hoge') }

    it { expect { exec_list_services }.to raise_error NotImplementedError }
  end

  context '.list_deployments' do
    subject(:exec_list_deployments) { described_class.list_deployments('hoge') }

    it { expect { exec_list_deployments }.to raise_error NotImplementedError }
  end

  context '.list_replica_sets' do
    subject(:exec_list_replica_sets) { described_class.list_replica_sets('hoge') }

    it { expect { exec_list_replica_sets }.to raise_error NotImplementedError }
  end

  context '.list_pods' do
    subject(:exec_list_pods) { described_class.list_pods('hoge') }

    it { expect { exec_list_pods }.to raise_error NotImplementedError }
  end

  context '.delete_ingresses' do
    subject(:exec_delete_ingresses) { described_class.delete_ingresses('hoge') }

    it { expect { exec_delete_ingresses }.to raise_error NotImplementedError }
  end

  context '.delete_services' do
    subject(:exec_delete_services) { described_class.delete_services('hoge') }

    it { expect { exec_delete_services }.to raise_error NotImplementedError }
  end

  context '.delete_deployments' do
    subject(:exec_delete_deployments) { described_class.delete_deployments('hoge') }

    it { expect { exec_delete_deployments }.to raise_error NotImplementedError }
  end

  context '.delete_replica_sets' do
    subject(:exec_delete_replica_sets) { described_class.delete_replica_sets('hoge') }

    it { expect { exec_delete_replica_sets }.to raise_error NotImplementedError }
  end

  context '.delete_pods' do
    subject(:exec_delete_pods) { described_class.delete_pods('hoge') }

    it { expect { exec_delete_pods }.to raise_error NotImplementedError }
  end

end
