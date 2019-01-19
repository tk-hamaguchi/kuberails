# frozen_string_literal: true

module Kuberails

  # Kuberails::Engine
  #
  # @version 0.1.0
  # @since 0.1.0
  #
  class Engine < ::Rails::Engine
    config.generators.api_only = true
  end
end
