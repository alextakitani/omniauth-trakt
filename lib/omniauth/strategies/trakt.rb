require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Trakt < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'trakt'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
          :authorize_url => "/oauth/authorize",
          :token_url => "/oauth/token",
          :site => "https://trakt.tv"
        }


      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid do
        access_token.params['uid']
      end

      info do
        access_token.params['info']
      end


    end
  end
end