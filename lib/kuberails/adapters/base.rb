# frozen_string_literal: true

module Kuberails::Adapters

  # Base class of adapter
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   0.1.0
  #
  class Base

    class << self
      # create_deployment
      def create_deployment(_yaml)
        raise NotImplementedError
      end

      # create_service
      def create_service(_yaml)
        raise NotImplementedError
      end

      # create_ingress
      def create_ingress(_yaml)
        raise NotImplementedError
      end

      # list_ingresses
      def list_ingresses(_label_selector)
        raise NotImplementedError
      end

      # list_services
      def list_services(_label_selector)
        raise NotImplementedError
      end

      # list_deployments
      def list_deployments(_label_selector)
        raise NotImplementedError
      end

      # list_replica_sets
      def list_replica_sets(_label_selector)
        raise NotImplementedError
      end

      # list_pods
      def list_pods(_label_selector)
        raise NotImplementedError
      end

      # destroy_ingresses
      def destroy_ingresses(_label_selector)
        raise NotImplementedError
      end

      # destroy_services
      def destroy_services(_label_selector)
        raise NotImplementedError
      end

      # destroy_deployments
      def destroy_deployments(_label_selector)
        raise NotImplementedError
      end

      # destroy_replica_sets
      def destroy_replica_sets(_label_selector)
        raise NotImplementedError
      end

      # destroy_pods
      def destroy_pods(_label_selector)
        raise NotImplementedError
      end
    end
  end
end
