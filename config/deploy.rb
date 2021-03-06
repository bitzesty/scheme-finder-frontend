set :application, "scheme-finder-frontend"
set :repo_url, "git@github.com:bitzesty/#{fetch(:application)}.git"
set :user, "schemer"

set :webserver, "passenger"

# slack
set :slack_team, "bitzesty"
set :slack_token, "C3U7O1JGkquaVCxR2npji90g"
set :slack_icon_emoji,   ->{ ":rocket:" }
set :slack_channel,      ->{ '#bis-growing-ambition' }

set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :scm, :git

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :branch, ENV["BRANCH"] || "master"
set :use_sudo, false

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{.env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle
                     public/system}

set :default_env, {
  "LANG" => "en_US.UTF-8",
  "PATH" => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
}
set :keep_releases, 5

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
fetch(:default_env).merge!(rails_env: fetch(:stage))
