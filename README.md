# Glass

A ruby client for the Glass Mirror API.

```ruby
glass = Glass::Client.new('access_token')

glass.timeline.insert(text: "Hello Paris", location: "Paris")

glass.timeline.list do |card|
	puts "#{card[:id]} - #{card[:text]}"
end
```
