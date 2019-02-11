# frozen_string_literal: true

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

end
