# Omniauth::Trakt

A Trakt.tv Oauth2 Provider Plugin Strategy for Omniauth


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-trakt'

And then execute:

    $ bundle

## Usage

### Devise / Omniauth
Add provider to your `config/initializers/devise.rb` ex:

```ruby
config.omniauth :trakt, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::Trakt
```

### Omniauth / Rails
Add provider to your `config/initializers/omniauth.rb` ex:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :trakt, 'APP_KEY', 'APP_SECRET',
                  strategy_class: OmniAuth::Strategies::Trakt
end
```


## Add callback

Configure routes to add omniauth callbacks controller `config/routes.rb` (which you implement):

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
```
Implement omniauth_callbacks controller `app/controllers/omniauth_callbacks_controller.rb` :

```ruby
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def trakt
    #You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_trakt(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Trakt Oauth"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.trakt"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
```



## License
Copyright (c) 2015 Alex Takitani

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
