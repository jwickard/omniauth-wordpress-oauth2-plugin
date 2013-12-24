require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class WordpressOauth2Plugin < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'wordpress_oauth2'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, { token_url: "/oauth/request_token", access_url: "/oauth/request_access"}


      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['ID'] }

      info do
        {
            name: raw_info['display_name'],
            email: raw_info['user_email'],
            nickname: raw_info['user_nicename'],
            urls: { "Website" => raw_info['user_url'] }

        }
      end

      extra do
        raw_info
      end

      def raw_info
        puts access_token.to_yaml
        @raw_info ||= access_token.get('/oauth/request_access').parsed
      end
    end
  end
end