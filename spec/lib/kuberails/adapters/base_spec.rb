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
  it { is_expected.to respond_to :destroy_ingresses }
  it { is_expected.to respond_to :destroy_services }
  it { is_expected.to respond_to :destroy_deployments }
  it { is_expected.to respond_to :destroy_replica_sets }
  it { is_expected.to respond_to :destroy_pods }

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

  context '.destroy_ingresses' do
    subject(:exec_destroy_ingresses) { described_class.destroy_ingresses('hoge') }

    it { expect { exec_destroy_ingresses }.to raise_error NotImplementedError }
  end

  context '.destroy_services' do
    subject(:exec_destroy_services) { described_class.destroy_services('hoge') }

    it { expect { exec_destroy_services }.to raise_error NotImplementedError }
  end

  context '.destroy_deployments' do
    subject(:exec_destroy_deployments) { described_class.destroy_deployments('hoge') }

    it { expect { exec_destroy_deployments }.to raise_error NotImplementedError }
  end

  context '.destroy_replica_sets' do
    subject(:exec_destroy_replica_sets) { described_class.destroy_replica_sets('hoge') }

    it { expect { exec_destroy_replica_sets }.to raise_error NotImplementedError }
  end

  context '.destroy_pods' do
    subject(:exec_destroy_pods) { described_class.destroy_pods('hoge') }

    it { expect { exec_destroy_pods }.to raise_error NotImplementedError }
  end

end
