# frozen_string_literal: true

module Kuberails

  # 設定オブジェクト
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   1.0.0
  #
  class Configuration

    K8S_NAMESPACE_FILE_PATH = '/var/run/secrets/kubernetes.io/serviceaccount/namespace'
    K8S_TOKEN_FILE_PATH     = '/var/run/secrets/kubernetes.io/serviceaccount/token'

    attr_accessor :k8s_url
    attr_accessor :k8s_namespace
    attr_accessor :k8s_token
    attr_accessor :adapter

    # コンストラクタ
    #
    # @param [String] k8s_url KubernetesAPIのURL
    # @param [String] k8s_namespace 操作対象のリソースがあるNamespace
    # @param [String] k8s_token KubernetesAPIを実行する際の認証トークン
    # @param [Symbol] adapter 利用するKubernetesクライアントライブラリ (default: kubeclient)
    #
    def initialize(k8s_url: nil, k8s_namespace: nil, k8s_token: nil, adapter: nil)
      build_k8s_url(k8s_url)
      build_k8s_namespace(k8s_namespace)
      build_k8s_token(k8s_token)
      build_adapter(adapter)
    end

    # 設定情報の検証
    #
    # @return [Boolean] 問題がなければtrue、問題があればfalseを返す
    #
    def valid?
      (@k8s_url.present? && @k8s_namespace.present? && @k8s_token.present?)
    end

    private

    def build_k8s_url(k8s_url)
      @k8s_url = if k8s_url.present?
                   k8s_url
                 elsif ENV.key?('KUBERNETES_SERVICE_HOST') && ENV.key?('KUBERNETES_SERVICE_PORT_HTTPS')
                   "https://#{ENV['KUBERNETES_SERVICE_HOST']}:#{ENV['KUBERNETES_SERVICE_PORT_HTTPS']}"
                 else
                   default_k8s_url
                 end
    end

    def build_k8s_namespace(k8s_namespace)
      @k8s_namespace = if k8s_namespace.present?
                         k8s_namespace
                       elsif File.exist?(K8S_NAMESPACE_FILE_PATH)
                         File.read(K8S_NAMESPACE_FILE_PATH).strip
                       else
                         default_k8s_namespace
                       end
    end

    def build_k8s_token(k8s_token)
      @k8s_token = if k8s_token.present?
                     k8s_token
                   elsif File.exist?(K8S_TOKEN_FILE_PATH)
                     File.read(K8S_TOKEN_FILE_PATH).strip
                   end
    end

    def build_adapter(adapter)
      @adapter = if adapter.blank?
                   default_adapter
                 elsif adapter.is_a?(::Symbol)
                   adapter
                 elsif adapter.is_a?(::String)
                 else
                   raise AdapterConfigurationError, adapter
                 end
    end

    def default_k8s_url
      'https://kubernetes.default'
    end

    def default_k8s_namespace
      'default'
    end

    def default_adapter
      :kubeclient
    end
  end
end
