# frozen_string_literal: true

require 'kuberails/engine'

# Kubernetes resource manager with rails
#
# @author tk.hamaguchi@gmail.com
# @version 1.0.0
# @since   0.1.0
#
module Kuberails

  autoload :Configure,     'kuberails/configure'
  autoload :Configuration, 'kuberails/configuration'

  autoload :Error,                     'kuberails/errors/error'
  autoload :ConfigurationError,        'kuberails/errors/configuration_error'
  autoload :AdapterConfigurationError, 'kuberails/errors/adapter_configuration_error'

  # Adapter modules for client libs
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   0.1.0
  #
  module Adapters
    autoload :Base, 'kuberails/adapters/base'
  end

  include Configure
end
