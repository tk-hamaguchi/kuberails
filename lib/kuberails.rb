# frozen_string_literal: true

require 'kuberails/engine'

# Kubernetes resource manager with rails
#
# @author tk.hamaguchi@gmail.com
# @version 1.0.0
# @since   0.1.0
#
module Kuberails
  autoload :Error,                     'kuberails/errors/error'
  autoload :ConfigurationError,        'kuberails/errors/configuration_error'
  autoload :AdapterConfigurationError, 'kuberails/errors/adapter_configuration_error'

  autoload :Logger, 'kuberails/logger'

  autoload :Configuration, 'kuberails/configuration'
  autoload :Configure,     'kuberails/configure'

  # Adapter modules for client libs
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   0.1.0
  #
  module Adapters
    autoload :Base, 'kuberails/adapters/base'
  end

  include Logger
  include Configure
end
