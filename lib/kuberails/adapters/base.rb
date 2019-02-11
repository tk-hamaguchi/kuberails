# frozen_string_literal: true

module Kuberails::Adapters

  # Base class of adapter
  #
  # @author tk.hamaguchi@gmail.com
  # @version 1.0.0
  # @since   0.1.0
  #
  class Base

    # @!visibility private
    # :nodoc:
    def self.method_missing(method, *args)
      if method.match?(/\A(create|list|get|update|patch|delete)_/)
        raise NotImplementedError, "You must implement #{self}.#{method}"
      end

      super
    end

    # @!visibility private
    # :nodoc:
    def self.respond_to_missing?(method, *args)
      method.match?(/\A(create|list|get|update|patch|delete)_/) || super
    end

  end
end
