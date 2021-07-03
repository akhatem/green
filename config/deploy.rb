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

# set :pty, true

SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"

namespace :sidekiq do
    after 'deploy:starting', 'sidekiq:stop'
    after 'deploy:finished', 'sidekiq:start'
  
    task :stop do
      on roles(:app) do
        within current_path do
          execute('systemctl kill -s TSTP sidekiq')
          execute('systemctl stop sidekiq')
        end
      end
    end
  
    task :start do
      on roles(:app) do |host|
        execute('systemctl start sidekiq')
        info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
      end
    end
end
