# config valid only for current version of Capistrano
lock '3.4.1'

set :application, "course-fees.umn.edu"
set :repo_url, "git@github.umn.edu:asrweb/umn_course_fees.git"

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/swadm/www/#{fetch(:application)}"
set :linked_files, %w(config/database.yml config/initializers/environment_variables.rb)
set :linked_dirs, %w(log tmp)

set :tmp_dir, File.join(fetch(:deploy_to), "tmp")

set :passenger_restart_with_touch, true

set :ssh_options,
    user: 'swadm',
    forward_agent: true,
    auth_methods: %w(publickey)

namespace :deploy do
  desc 'Update the data_view views'
  task :update_views, [:command] => 'deploy:set_rails_env' do
    on primary(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "view_builder:build_all"
        end
      end
    end
  end

  after :published, :update_views
end
