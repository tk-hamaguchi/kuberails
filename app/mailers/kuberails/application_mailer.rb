# frozen_string_literal: true

module Kuberails

  # Kuberails::ApplicationMailer
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end
