require 'stripe'
require 'sinatra'

# This is your test secret API key.
Stripe.api_key = 'sk_test_51Q9KsmD7l1Q7vQvXSQZAXJ1i6s9sCIItKPYIBWWyvLD8LWMMT1R6BdiK3GOTLHbfdSKOTG0xlvUsEIFpxdXrVIQ700hGfxkUcv'

set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://alexdotyswag.com:4242'

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    line_items: [{
      # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
      price: '{{PRICE_ID}}',
      quantity: 1,
    }],
    mode: 'payment',
    success_url: YOUR_DOMAIN + '/success.html',
    cancel_url: YOUR_DOMAIN + '/cancel.html',
    automatic_tax: {enabled: true},
  })
  redirect session.url, 303
end
