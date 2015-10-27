Rails.application.config.middleware.use OmniAuth::Builder do
  binding.pry
  provider :delivery, Rails.application.secrets.delivery_client_id, Rails.application.secrets.delivery_client_secret
end