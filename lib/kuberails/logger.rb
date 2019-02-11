# frozen_string_literal: true

module Kuberails

  # Logger module
  #
  # @author  tk.hamaguchi@gmail.com
  # @since   1.0.0
  # @version 1.0.0
  #
  module Logger

    # Kuberails::Logger.included
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Kuberails::Logger::ClassMethods
    module ClassMethods

      # Loggerの取得
      #
      # @return [ActiveSupport::Logger] ロガー
      #
      def logger
        @logger ||= Rails.logger
      end

      # Loggerを設定
      #
      # @param [::Logger] logger 新しいロガー
      # @return [::Logger] 新しいロガー
      #
      def logger=(logger)
        @logger = logger
      end
    end
  end
end
