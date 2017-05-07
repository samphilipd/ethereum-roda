# Applied Blockchain Ruby Test #1

# Setup

`$ bundle`

# Run the app

`$ bundle exec rackup -p 9292 config.ru`

Now visit localhost:9292 for a sanity check.

# Testing

`$ bundle exec rspec`

# Use the app

`$ curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST -d '{"address":"0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c"}' localhost:9292/accounts`
`$ curl -H "Accept: application/json" localhost:9292/accounts`

