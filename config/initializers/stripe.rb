unless Rails.env.production?
  ENV['STRIPE_PUBLISHABLE_KEY'] = 'pk_test_VokZAt23FJvt1fpcEhMhK76h'
  ENV['STRIPE_SECRET_KEY'] = 'sk_test_Muc0ZOevjI16ncKjSUIRyAFC'
end

Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY'],
}

Stripe.api_key = \
  Rails.configuration.stripe[:secret_key]
