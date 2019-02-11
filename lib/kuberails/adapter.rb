# frozen_string_literal: true

module Kuberails

  # Adapter module
  #
  # @author  tk.hamaguchi@gmail.com
  # @since   1.0.0
  # @version 1.0.0
  #
  module Adapter

    # Kuberails::Adapter.included
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Kuberails::Adapter::ClassMethods
    module ClassMethods

      # Adapterの取得
      #
      # @return [Kuberails::Adapters::Base] Adapter for kubernetes
      # @raise [Kuberails::AdapterConfigurationError] Configured unknown adapter type
      #
      def adapter
        Kuberails::Adapters.const_get configuration.adapter.to_s.classify
      rescue NameError => err
        raise AdapterConfigurationError, configuration.adapter
      end
    end
  end
end
