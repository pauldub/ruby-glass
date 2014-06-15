# Glass

A ruby client for the Glass Mirror API.

```ruby
glass = Glass::Client.new('access_token')

glass.timeline.insert(text: "Hello Paris", location: "Paris")

glass.timeline.list do |card|
	puts "#{card[:id]} - #{card[:text]}"
end
```

## Todo

- Actually test that library works.
- Write tests.
- Document.

## Supported APIs

- [Timeline](https://developers.google.com/glass/v1/reference/timeline)
- [Subscriptions](https://developers.google.com/glass/v1/reference/subscriptions)
- [Locations](https://developers.google.com/glass/v1/reference/locations)
- [Contacts](https://developers.google.com/glass/v1/reference/contacts)
- [Accounts](https://developers.google.com/glass/v1/reference/accounts)
- [Settings](https://developers.google.com/glass/v1/reference/settings)
