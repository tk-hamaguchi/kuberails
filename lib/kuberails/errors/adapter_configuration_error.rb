# frozen_string_literal: true

module Kuberails

  # Kuberails::AdapterConfigurationError
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since 1.0.0
  #
  class AdapterConfigurationError < ConfigurationError

    # コンストラクタ
    #
    # @version 1.0.0
    # @since 1.0.0
    #
    # @param adapter [String] Name of adapter
    #
    def initialize(adapter)
      super "Unknown adapter type #{adapter}"
      @adapter = adapter
    end
  end
end
