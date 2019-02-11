module Kuberails
  class Engine < ::Rails::Engine
    isolate_namespace Kuberails
    config.generators.api_only = true
  end
end
