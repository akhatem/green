# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
require 'capistrano/sidekiq'


require 'capistrano/rails'
require 'capistrano/passenger'
require 'capistrano/rbenv'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Sidekiq
# install_plugin Capistrano::Sidekiq::Systemd
install_plugin Capistrano::Sidekiq::Upstart
# install_plugin Capistrano::Sidekiq::Monit

set :rbenv_type, :user
set :rbenv_ruby, '3.0.0'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }