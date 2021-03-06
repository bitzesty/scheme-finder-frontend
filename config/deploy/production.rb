set :stage, :production
set :rails_env, :production
set :branch, ENV["BRANCH"] || "production"

set :ip, "89.200.142.59"
set :domain_name, "growingambitions.educationandemployers.org"

server fetch(:ip), user: fetch(:user), roles: %w(app web)
