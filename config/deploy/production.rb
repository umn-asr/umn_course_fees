set :rails_env, "production"

server "asr-coursefees-prd-app-04.oit.umn.edu",
  roles: %w[web app db prod]
