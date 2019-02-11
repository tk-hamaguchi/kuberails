# frozen_string_literal: true

module Kuberails

  # Kuberails::ApplicationRecord
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
