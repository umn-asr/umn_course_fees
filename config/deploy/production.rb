# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don"t declare `role :all`, it"s a meta role
# role :app, %w{deploy@example.com}
role :app, %w(asr-coursefees-prd-web-02.oit.umn.edu)
role :web, %w(asr-coursefees-prd-web-02.oit.umn.edu)

# Configuration
set :user, "swadm"
set :server, "asr-coursefees-prd-web-02.oit.umn.edu"
set :roles, %w(web app)
set :web_root, "/swadm/www/"

server(
  "asr-coursefees-prd-web-02.oit.umn.edu",
  roles: fetch(:roles),
  web_root: fetch(:web_root)
)
