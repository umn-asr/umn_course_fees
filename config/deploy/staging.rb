set :rails_env, "staging"

server "asr-coursefees-qat-app-04.oit.umn.edu",
  roles: %w[web app db prod]
