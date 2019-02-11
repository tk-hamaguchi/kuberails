class Kuberails::DeploymentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def copy_template_file
    copy_file 'deployment.yaml.erb',
      Kuberails.configuration.app_dir.join('deployments', "#{name.underscore}.yaml.erb")

    template 'deployment.rb.erb',
             Rails.root.join('app', 'models', "#{name.underscore}_deployment.rb")
  end
end
