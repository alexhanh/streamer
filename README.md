# Examples

```ruby
provider = Streamer.setup(:own3d)

live_streams = provider.list(:game => 'sc2')

for stream in results
  p stream.id

  if stream.live?
    p stream.title
    p stream.viewers
    p stream.uptime
    p stream.url
  end
end
```