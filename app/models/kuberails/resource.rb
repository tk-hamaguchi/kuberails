# frozen_string_literal: true

module Kuberails

  # Base resource for kuberails
  class Resource < ApplicationRecord

    validates :entity_type,
      presence: true

    validates :resource_name,
      presence: true

    validates :namespace,
      presence: true

    validates :name,
      uniqueness: { scope: %i[namespace resource_name], case_sensitive: false },
      presence: true

    after_initialize do |resource|
      if resource.new_record? && !resource.instance_of?(Kuberails::Resource)
        resource.entity_type   ||= resource.class::EntityType
        resource.resource_name ||= resource.class::ResourceName
        resource.namespace     ||= Kuberails.configuration.k8s_namespace
      end
    end

    after_validation :setup_yaml

    def build_yaml(path)
      ERB.new(File.read(Rails.root.join(path)), nil, '-').result(binding)
    end

    def setup_yaml(path = template_path)
      self.yaml ||= build_yaml(path)
    end

    def create_resource
      Kuberails.adapter.send("create_#{resource_name.singularize}".to_sym, yaml)
    end
  end
end
