class GmailOauthService
  TOKEN_CREDENTIAL_URI = 'https://oauth2.googleapis.com/token'.freeze
  SCOPE = ['https://mail.google.com/'].freeze

  def initialize
    @client_id = ENV['GMAIL_CLIENT_ID']
    @client_secret = ENV['GMAIL_CLIENT_SECRET']
    @refresh_token = ENV['GMAIL_REFRESH_TOKEN']
    @user_email = ENV['GMAIL_USER_EMAIL']
  end

  def access_token
    client = Signet::OAuth2::Client.new(
      client_id: @client_id,
      client_secret: @client_secret,
      token_credential_uri: TOKEN_CREDENTIAL_URI,
      refresh_token: @refresh_token,
      scope: SCOPE,
      grant_type: 'refresh_token'
    )
    client.fetch_access_token!
    client.access_token
  end
end
