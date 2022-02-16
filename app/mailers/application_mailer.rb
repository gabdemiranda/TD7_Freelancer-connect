# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'contato@freelancerconnect.com.br'
  layout 'mailer'
end
