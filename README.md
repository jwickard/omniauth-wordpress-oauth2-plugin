# Omniauth::Wordpress

A Wordpress Oauth2 Provider Plugin Strategy for Omniauth

Use with the Wordpress Oauth2 Provider plugin to turn  your wordpress install into an authentication provider: https://github.com/jwickard/wordpress-oauth


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-wordpress_hosted', github: 'jwickard/omniauth-wordpress-oauth2-plugin'

And then execute:

    $ bundle

<!-- Or install it yourself as:

    $ gem install omniauth-wordpress-oauth2-plugin
-->
## Usage

### Devise / Omniauth
Add provider to your `config/initializers/devise.rb` ex:

```ruby
config.omniauth :wordpress_hosted, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::WordpressHosted, 
                  client_options: { site: 'http://yourcustomwordpress.com' }
```

### Omniauth / Rails
Add provider to your `config/initializers/omniauth.rb` ex:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wordpress_hosted, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::WordpressHosted, 
                  client_options: { site: 'http://yourcustomwordpress.com' }
end
```

## Add Provider to Wordpress
Asuming you have already installed the wordpress oauth2 provider plugin, add a provider for this rails applicaiton to the plugin configuration:

![alt tag](https://raw.github.com/jwickard/omniauth-wordpress-oauth2-plugin-example/master/config-screen.png)

make sure the callback url you have configured is of the form:

`http://your-rails-site.com/users/auth/wordpress_hosted/callback`

Then configure your rails application with the app key and secret generated by the wordpress plugin.

## Add callback

Configure routes to add omniauth callbacks controller `config/routes.rb` (which you implement):

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
```
Implement omniauth_callbacks controller `app/controllers/omniauth_callbacks_controller.rb` :

```ruby
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def wordpress_hosted
    #You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_wordpress_hosted(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Wordpress Oauth2"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.wordpress_hosted"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
```

### Example Oauth Data

```yaml
--- !ruby/hash:OmniAuth::AuthHash
provider: wordpress_hosted
uid: '2'
info: !ruby/hash:OmniAuth::AuthHash::InfoHash
  name: Joe Sandstone
  email: jsandstone@example.com
  nickname: jsand
  urls: !ruby/hash:OmniAuth::AuthHash
    Website: http://example.com
credentials: !ruby/hash:OmniAuth::AuthHash
  token: 4070b5be481b1a4110797763ac27359c1d1da3bb
  refresh_token: 212597ee673d630cfb95a77a69900c7ead1d3e19
  expires_at: 1387912450
  expires: true
extra: !ruby/hash:OmniAuth::AuthHash
  ID: '2'
  user_login: jsand
  user_nicename: jsand
  user_email: jsandstone@example.com
  user_url: http://example.com
  user_registered: '2013-12-12 15:29:34'
  user_status: '0'
  display_name: Joe Sandstone
```

### Example application 

https://github.com/jwickard/omniauth-wordpress-oauth2-plugin-example

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. 

## License
Copyright (c) 2013 Joel Wickard

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
