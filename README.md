# Kuberails

Kubernetes-API client plugin for ruby on rails.


## Getting started

Add this line to your application's Gemfile:

```ruby
gem 'kuberails'
```

And then execute:
```bash
$ bundle
```

And then execute:
```bash
$ bundle exec rails g kuberails:install
```

And then edit configuration:
```ruby:config/initializers/kuberails.rb
# Use this hook to configure kuberails.
Kuberails.configure do |config|

  # Configure the kubernetes api server's url.
  #   For example,
  #     default(internal) => 'https://kubernetes.default'.
  #     docker for mac    => 'https://localhost:6443'
  #     external k8s      => 'https://kubernetes.example.com:1443'
  # config.k8s_url = 'https://kubernetes.default'

  # Configure the kubernetes api token.  Default is content of the internal token file
  # (/var/run/secrets/kubernetes.io/serviceaccount/token).
  # config.k8s_token = 'your-k8s-token'

  # Configure the effective kubernetes namespace.  Default is content of the internal
  # namespace file (/var/run/secrets/kubernetes.io/serviceaccount/namespace).
  # config.k8s_namespace = 'kuerails-test'

  :
  :
```

And then generate kubernates resources:
```bash
$ bundle exec rails g kuberails:deployment bookmark
```

And then create in your ruby programs:
```ruby
deployment = BookmarkDeployment.new(name: 'hoge')
deployment.save
```

And then you can find hoge deployment in your cluster.


## Contributing

TBD.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
