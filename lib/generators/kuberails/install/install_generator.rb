class Kuberails::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/kuberails.rb'
  end

  def copy_migration_files
    rake 'kuberails:install:migrations'
  end
end
