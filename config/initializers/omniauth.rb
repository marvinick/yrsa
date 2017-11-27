OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '164993425998-i82c61f7pe2nj2t6noprqc8hsmp5a71v.apps.googleusercontent.com', '8dd8xjh-eA5JQ-YdJdSSECHy', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
