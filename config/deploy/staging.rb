set :rails_env, "staging"

server "asr-coursefees-qat-03.oit.umn.edu",
  roles: %w[web app db prod]
