# frozen_string_literal: true

module Kuberails

  # Kuberails::Engine
  class Engine < ::Rails::Engine
    isolate_namespace Kuberails
    config.generators.api_only = true
  end
end
