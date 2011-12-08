# Important
Please note that querying Own3D more frequently than once per couple of minutes results in unreliable data because of caching.

For JustinTV/TwitchTV, this is 60 seconds.
# Examples

```ruby
provider = Streamer.setup(:own3d)

live_streams = provider.list(:game => 'sc2')

for stream in live_streams
  p stream.id

  if stream.live?
    p stream.title
    p stream.viewers
    p stream.uptime
    p stream.url
  end
end
```