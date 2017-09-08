set :rails_env, "production"

server "asr-coursefees-prd-03.oit.umn.edu",
       roles: %w(web app db prod)
