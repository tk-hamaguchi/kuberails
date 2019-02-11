# frozen_string_literal: true

require 'kubeclient'

module Kuberails::Adapters

  # Kuberclient用アダプタ
  #
  # @author  tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   1.0.0
  #
  class Kubeclient < Base
    class << self

      # Kubernetes上にDeploymentリソースを作成する
      #
      # @param [String] yaml 作成したいリソース
      # @return [Hash] 作成結果のHash
      #
      def create_deployment(yaml)
        create_resource_with(kube_extensions_api_client, 'Deployment', yaml)
      end

      # Kubernetes上にServiceリソースを作成する
      #
      # @param [String] yaml 作成したいリソース
      # @return [Hash] 作成結果のHash
      #
      def create_service(yaml)
        create_resource_with(kube_client, 'Service', yaml)
      end

      # Kubernetes上にIngressリソースを作成する
      #
      # @param [String] yaml 作成したいリソース
      # @return [Hash] 作成結果のHash
      #
      def create_ingress(yaml)
        create_resource_with(kube_extensions_api_client, 'Ingress', yaml)
      end

      # Kubernetes上のDeploymentリソースを取得する
      #
      # @param [String] label_selector Deploymentのラベル
      # @return [Hash] 取得結果のHash
      # @raise [RuntimeError] 対象ラベルで検索した結果が０件
      #
      def find_deployments!(label_selector)
        options     = default_label_selector.merge(label_selector: label_selector)
        deployments = kube_extensions_api_client.get_entities('Deployment', 'deployments', options)
        raise "Deployment not found !  (label_selector: #{label_selector})" if deployments.empty?

        deployments.first
      end

      # Kubernetes上のIngressリソースを検索する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 検索結果のHashを配列にしたもの
      #
      def list_ingresses(label_selector)
        list_resources_with(kube_extensions_api_client, 'Ingress', label_selector)
      end

      # Kubernetes上のServiceリソースを検索する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 検索結果のHashを配列にしたもの
      #
      def list_services(label_selector)
        list_resources_with(kube_client, 'Service', label_selector)
      end

      # Kubernetes上のDeploymentリソースを検索する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 検索結果のHashを配列にしたもの
      #
      def list_deployments(label_selector)
        list_resources_with(kube_extensions_api_client, 'Deployment', label_selector)
      end

      # Kubernetes上のReplicaSetリソースを検索する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 検索結果のHashを配列にしたもの
      #
      def list_replica_sets(label_selector)
        list_resources_with(kube_extensions_api_client, 'ReplicaSet', label_selector)
      end

      # Kubernetes上のPodリソースを検索する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 検索結果のHashを配列にしたもの
      #
      def list_pods(label_selector)
        list_resources_with(kube_client, 'Pod', label_selector)
      end

      # Kubernetes上のIngressリソースを削除する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 削除したリソースのHashを配列にしたもの
      #
      def delete_ingresses(label_selector)
        delete_resources_with(kube_extensions_api_client, 'Ingress', label_selector)
      end

      # Kubernetes上のServiceリソースを削除する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 削除したリソースのHashを配列にしたもの
      #
      def delete_services(label_selector)
        delete_resources_with(kube_client, 'Service', label_selector)
      end

      # Kubernetes上のDeploymentリソースを削除する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 削除したリソースのHashを配列にしたもの
      #
      def delete_deployments(label_selector)
        delete_resources_with(kube_extensions_api_client, 'Deployment', label_selector)
      end

      # Kubernetes上のReplicaSetリソースを削除する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 削除したリソースのHashを配列にしたもの
      #
      def delete_replica_sets(label_selector)
        delete_resources_with(kube_extensions_api_client, 'ReplicaSet', label_selector)
      end

      # Kubernetes上のPodリソースを削除する
      #
      # @param [String] label_selector 検索条件のラベル
      # @return [Array] 削除したリソースのHashを配列にしたもの
      #
      def delete_pods(label_selector)
        delete_resources_with(kube_client, 'Pod', label_selector)
      end

      private

      def kube_client(uri = nil, version = 'v1', options = {})
        uri ||= "#{Kuberails.configuration.k8s_url}/api"
        client_opts = default_kube_client_options.merge(options)

        p client_opts
        Kubeclient::Client.new(uri, version, client_opts)
      end

      def kube_extensions_api_client
        kube_client("#{Kuberails.configuration.k8s_url}/apis/extensions", 'v1beta1')
      end

      def create_resource_with(client, resource_type_obj, yaml)
        resource_type  = sanitize_resource_type(resource_type_obj)
        resource_types = resource_type.downcase.pluralize

        Kuberails.logger.debug "Create #{resource_type} with ...\n#{yaml}"
        resource = Kubeclient::Resource.new(YAML.safe_load(yaml).deep_symbolize_keys)
        result   = client.create_entity(resource_type, resource_types, resource).to_hash
        Kuberails.logger.info "Create #{resource_type} \"#{resource.metadata.name}\"."

        result
      end

      def list_resources_with(client, resource_type_obj, label_selector)
        resource_type  = sanitize_resource_type(resource_type_obj)
        resource_types = resource_type.downcase.pluralize
        options        = default_label_selector.merge(label_selector: label_selector)

        client.get_entities(resource_type, resource_types, options).map(&:to_h)
      end

      def delete_resources_with(client, resource_type_obj, label_selector)
        results        = []
        resource_type  = sanitize_resource_type(resource_type_obj)
        resource_types = resource_type.downcase.pluralize

        list_resources_with(client, resource_type, label_selector).each do |resource|
          results << client.delete_entity(resource_types, resource[:metadata][:name],
                                          Kuberails.configuration.k8s_namespace).to_h
          Kuberails.logger.info "Delete replica set \"#{resource[:metadata][:name]}\"."
        end

        results
      end

      def sanitize_resource_type(resource_type)
        resource_type.is_a?(Symbol) ? resource_type.to_s.camelize : resource_type
      end

      def default_label_selector
        {
          namespace: Kuberails.configuration.k8s_namespace
        }
      end

      def default_kube_client_options
        {
          auth_options: { bearer_token: Kuberails.configuration.k8s_token },
          ssl_options:  { verify_ssl:   OpenSSL::SSL::VERIFY_NONE }
        }
      end
    end
  end
end
