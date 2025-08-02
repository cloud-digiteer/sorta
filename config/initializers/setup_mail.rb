Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'sorta-qkff.onrender.com',  # your actual domain here
  authentication: :xoauth2,
  user_name: ENV['GMAIL_USER_EMAIL'],
  oauth2_token: nil,  # will be set dynamically below
  enable_starttls_auto: true
}

module ActionMailer
  class Base
    alias_method :orig_mail, :mail

    def mail(headers = {}, &block)
      gmail_oauth = GmailOauthService.new
      settings = self.class.smtp_settings
      settings[:oauth2_token] = gmail_oauth.access_token
      self.class.smtp_settings = settings
      orig_mail(headers, &block)
    end
  end
end
