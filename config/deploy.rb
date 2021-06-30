# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "green"
set :repo_url, "git@github.com:akhatem/green.git"

set :branch, 'master'

set :deploy_to, "/home/deploy/#{fetch :application}"

# set :passenger_in_gemfile, true

set :rails_env, "production"

# set :sidekiq_monit_use_sudo, false

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'public/packs', 'node_modules'

set :keep_releases, 5

# SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
# SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"
