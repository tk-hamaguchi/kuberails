# frozen_string_literal: true

module Kuberails

  # Configuration management module
  #
  # @author  tk.hamaguchi@gmail.com
  # @since   1.0.0
  # @version 1.0.0
  #
  module Configure

    # Kuberails::Configure.included
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Kuberails::Configure::ClassMethods
    module ClassMethods

      # 設定情報の取得
      #
      # @return [Kuberails::Configuration] 設定情報
      #
      def configuration
        @configuration ||= Kuberails::Configuration.new
      end

      # 設定情報の初期化
      #
      # @return [Kuberails::Configuration] 設定情報
      #
      def reset
        @configuration = Kuberails::Configuration.new
      end

      # 設定の実行
      #
      def configure
        yield(configuration)
      end
    end
  end
end
