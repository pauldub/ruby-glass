# ruby-glass

A Ruby 2.x client for the Glass Mirror API.

```ruby
glass = Glass::Client.new('access_token')

glass.timeline.insert(text: "Hello Paris", location: "Paris")

glass.timeline.list do |card|
	puts "#{card[:id]} - #{card[:text]}"
end
```

## Todo

- Write tests.
- Document.
- Wrap options (for the client, but also for oauth authorization, etc.) in a separate class.

## Supported APIs

- [Timeline](https://developers.google.com/glass/v1/reference/timeline)
- [Subscriptions](https://developers.google.com/glass/v1/reference/subscriptions)
- [Locations](https://developers.google.com/glass/v1/reference/locations)
- [Contacts](https://developers.google.com/glass/v1/reference/contacts)
- [Accounts](https://developers.google.com/glass/v1/reference/accounts)
- [Settings](https://developers.google.com/glass/v1/reference/settings)

## Obtaining an access token

The following steps can be done to get an access token:

- Initialiaze the `Glass::Client` with your `client_id` and `client_secret`:

```ruby
client = Glass::Client.new(nil, client_id: 'foo', client_secret: 'bar')
```

- Get an authorization code by sending the user to your application's authorization url:

```ruby
url = client.authorize_url
```

- Ask the user for the authorization code and exchange it for an access token:

```ruby
token = client.get_token('the authorization code').token
```

- Now you can create a client using only the access token:

```ruby
client = Glass::Client.new(token)
```

This `client_id` and `client_secret` are not required to access the API on behalf of the user but they are required in order to perform authorization. You will probably grab the access token by different means (eg: With omniauth in a web application). 

If refresh tokens where to be used, `client_id` and `client_secret` would be required for it too.

