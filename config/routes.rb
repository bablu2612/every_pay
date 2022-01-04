Rails.application.routes.draw do
  resources :every_pays
 
  get '/paid' ,to: "every_pays#payment_success" #for success_payment
  post '/every_pay/payment' , to: "every_pays#payment" #for create or genrate payment links.
  root 'every_pays#index'
end
