# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kuberails::Configuration do
  subject(:described_instance) { described_class.new(args) }

  let(:args) { {} }

  it { is_expected.to respond_to :k8s_url }
  it { is_expected.to respond_to :k8s_url= }
  it { is_expected.to respond_to :k8s_namespace }
  it { is_expected.to respond_to :k8s_namespace= }
  it { is_expected.to respond_to :k8s_token }
  it { is_expected.to respond_to :k8s_token= }
  it { is_expected.to respond_to :adapter }
  it { is_expected.to respond_to :adapter= }

  context 'constructor' do
    context 'inner kubernetes with namespace' do
      before do
        allow(ENV).to receive(:key?).and_return(true)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_HOST').and_return('hoge.example.com')
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_PORT_HTTPS').and_return('1234')
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:read).with('/var/run/secrets/kubernetes.io/serviceaccount/namespace')
                                     .and_return("dummy-namespace\n")
        allow(File).to receive(:read).with('/var/run/secrets/kubernetes.io/serviceaccount/token')
                                     .and_return("dummy-token\n")
      end

      context 'with no args' do
        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://hoge.example.com:1234' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'dummy-namespace' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to eq 'dummy-token' }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :kubeclient }
        end
      end

      context 'with (k8s_url: "https://example.com:9012/", k8s_namespace: "hoge", k8s_token: "fuga", adapter: :puki)' do
        let(:args) do
          {
            k8s_url:       'https://example.com:9012/',
            k8s_namespace: 'hoge',
            k8s_token:     'fuga',
            adapter:       :puki
          }
        end

        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://example.com:9012/' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'hoge' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to eq 'fuga' }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :puki }
        end
      end
    end

    context 'inner kubernetes without namespace' do
      before do
        allow(ENV).to receive(:key?).and_return(true)
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_HOST').and_return('fuga.example.net')
        allow(ENV).to receive(:[]).with('KUBERNETES_SERVICE_PORT_HTTPS').and_return('5678')
        allow(File).to receive(:exist?).with('/var/run/secrets/kubernetes.io/serviceaccount/namespace')
                                       .and_return(false)
        allow(File).to receive(:exist?).with('/var/run/secrets/kubernetes.io/serviceaccount/token')
                                       .and_return(true)
        allow(File).to receive(:read).with('/var/run/secrets/kubernetes.io/serviceaccount/token')
                                     .and_return("dummy-token\n")
      end

      context 'with no args' do
        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://fuga.example.net:5678' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'default' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to eq 'dummy-token' }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :kubeclient }
        end
      end

      context 'with (k8s_url: "https://example.com:9012/", k8s_namespace: "hoge", k8s_token: "fuga", adapter: :puki)' do
        let(:args) do
          {
            k8s_url:       'https://example.com:9012/',
            k8s_namespace: 'hoge',
            k8s_token:     'fuga',
            adapter:       :puki
          }
        end

        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://example.com:9012/' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'hoge' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to eq 'fuga' }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :puki }
        end
      end
    end

    context 'outer kubernetes' do
      before do
        allow(ENV).to receive(:key?).and_return(false)
        allow(File).to receive(:exist?).and_return(false)
      end

      context 'with no args' do
        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://kubernetes.default' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'default' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to be_nil }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :kubeclient }
        end
      end

      context 'with (k8s_url: "https://example.com:9012/", k8s_namespace: "hoge", k8s_token: "fuga", adapter: :puki)' do
        let(:args) do
          {
            k8s_url:       'https://example.com:9012/',
            k8s_namespace: 'hoge',
            k8s_token:     'fuga',
            adapter:       :puki
          }
        end

        context '@k8s_url' do
          subject { described_instance.instance_variable_get(:@k8s_url) }

          it { is_expected.to eq 'https://example.com:9012/' }
        end

        context '@k8s_namespace' do
          subject { described_instance.instance_variable_get(:@k8s_namespace) }

          it { is_expected.to eq 'hoge' }
        end

        context '@k8s_token' do
          subject { described_instance.instance_variable_get(:@k8s_token) }

          it { is_expected.to eq 'fuga' }
        end

        context '@adapter' do
          subject { described_instance.instance_variable_get(:@adapter) }

          it { is_expected.to eq :puki }
        end
      end
    end
  end

  context '#valid?' do
    subject { described_instance.valid? }

    let(:k8s_url) { 'https://hoge.example.com:3456/' }
    let(:k8s_namespace) { 'fuga' }
    let(:k8s_token) { 'puki' }
    let(:adapter) { :kubehoge }

    before do
      described_instance.instance_variable_set :@k8s_url, k8s_url
      described_instance.instance_variable_set :@k8s_namespace, k8s_namespace
      described_instance.instance_variable_set :@k8s_token, k8s_token
      described_instance.instance_variable_set :@adapter, adapter
    end

    context 'with @k8s_url => "https://hoge.example.com:3456/", @k8s_namespace => "fuga", ' \
            '@k8s_token => "hoge", @adapter => :kubehoge' do
      it { is_expected.to eq true }
    end

    context 'with @k8s_url => "https://hoge.example.com:3456/", @k8s_namespace => "fuga", ' \
            '@k8s_token => "hoge", @adapter => nil' do
      let(:adapter) { nil }

      it { is_expected.to eq true }
    end

    context 'with @k8s_url => "https://hoge.example.com:3456/", @k8s_namespace => "fuga", ' \
            '@k8s_token => nil, @adapter => :kubehoge' do
      let(:k8s_token) { nil }

      it { is_expected.to eq false }
    end

    context 'with @k8s_url => "https://hoge.example.com:3456/", @k8s_namespace => nil, ' \
            '@k8s_token => "hoge", @adapter => :kubehoge' do
      let(:k8s_namespace) { nil }

      it { is_expected.to eq false }
    end

    context 'with @k8s_url => nil, @k8s_namespace => "fuga", @k8s_token => "hoge", @adapter => :kubehoge' do
      let(:k8s_url) { nil }

      it { is_expected.to eq false }
    end
  end
end
