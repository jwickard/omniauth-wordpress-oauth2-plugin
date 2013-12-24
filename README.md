# Omniauth::Wordpress::Oauth2::Plugin

A Wordpress Oauth2 Provider Plugin Strategy for Omniauth

Use with the Wordpress Oauth2 Provider plugin to turn  your wordpress install into an authentication provider: https://github.com/jwickard/wordpress-oauth


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-wordpress-oauth2-plugin', github: 'jwickard/omniauth-wordpress-oauth2-plugin'

And then execute:

    $ bundle

<!-- Or install it yourself as:

    $ gem install omniauth-wordpress-oauth2-plugin
-->
## Usage

### Devise / Omniauth
Add provider to your `config/initializers/devise.rb` ex:

```ruby
config.omniauth :wordpress_oauth2, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::WordpressOauth2Plugin, 
                  client_options: { site: 'http://yourcustomwordpress.com' }
```

### Omniauth / Rails
Add provider to your `config/initializers/omniauth.rb` ex:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wordpress_oauth2, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::WordpressOauth2Plugin, 
                  client_options: { site: 'http://yourcustomwordpress.com' }
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
