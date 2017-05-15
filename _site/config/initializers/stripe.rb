unless Rails.env.production?
  ENV['STRIPE_PUBLISHABLE_KEY'] = 'pk_test_53w2VIecCz5x5QnNZVqFlq3d'
  ENV['STRIPE_SECRET_KEY'] = 'sk_test_wTWQ3hd4Otb1aZUVcmZ2F3rc'
end

Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY'],
}

Stripe.api_key = \
  Rails.configuration.stripe[:secret_key]
