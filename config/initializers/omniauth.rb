Rails.application.config.middleware.use OmniAuth::Builder do
  provider :delivery, Rails.application.secrets.delivery_client_id, Rails.application.secrets.delivery_client_secret
end