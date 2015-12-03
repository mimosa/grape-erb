# Grape::Erb

Use [Erb](https://github.com/mimosa/erb) templates in [Grape](https://github.com/intridea/grape)!

## Installation

Add the `grape` and `grape-erb` gems to Gemfile.

```ruby
gem 'grape'
gem 'grape-erb'
```

And then execute:

    $ bundle

## Usage

### Setup view root directory
```ruby
# config.ru
use Rack::Config do |env|
  env['api.tilt.root'] = '/path/to/view/root/directory'
end
```

### Tell your API to use Grape::Formatter::Erb

```ruby
class API < Grape::API
  content_type :json, 'application/json'
  content_type :html, 'text/html'
  formatter :html, Grape::Formatter::Erb
  format :html
end
```

### Use erb templates conditionally

Add the template name to the API options.

```ruby
get "/user/:id", erb: "users/show" do
  @user = User.find(params[:id])
end
```

You can use instance variables in the Erb template.

```ruby
<% unless @user.nil? %>
  <h2><%= @user.name %></h2>
  <p><%= @user.bio %></p>
<% end %>
```

### Use erb layout

Gape-erb first looks for a layout file in `#{env['api.tilt.root']}/layouts/application.html.erb`.

You can override the default layout conventions:

```ruby
# config.ru
use Rack::Config do |env|
  env['api.tilt.root'] = '/path/to/view/root/directory'
  env['api.tilt.layout'] = 'layouts/another'
end
```

### Enable template caching

Grape-erb allows for template caching after templates are loaded initially.

You can enable template caching:

```ruby
# config.ru
Grape::Erb.configure do |c|
  c.cache_template_loading = true # default: false
end
```

## You can omit .erb

The following are identical.

```ruby
get "/home", erb: "view"
get "/home", erb: "view.html.erb"
```

## Usage with rails

Create grape application

```ruby
# app/api/user.rb
class MyAPI < Grape::API
  content_type :json, 'application/json'
  content_type :js,   'text/javascript'
  content_type :html, 'text/html'
  
  formatter :html, Grape::Formatter::Erb
  formatter :js,   Grape::Formatter::Erb

  format :json # Default format

  get '/user/:id' do
    env['api.format'] = :html
    content_type 'text/html'

    @user = User.find(params[:id])

    render erb: 'users/show'
  end
end
```

```ruby
# app/views/api/user.html.erb
<% unless @user.nil? %>
  <h2><%= @user.name %></h2>
  <p><%= @user.bio %></p>
<% end %>
```

Edit your **config/application.rb** and add view path

```ruby
# application.rb
class Application < Rails::Application
  config.middleware.use(Rack::Config) do |env|
    env['api.tilt.root'] = Rails.root.join "app", "views", "api"
  end
end
```

## Specs

See ["Writing Tests"](https://github.com/intridea/grape#writing-tests) in [https://github.com/intridea/grape](grape) README.

Enjoy :)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request