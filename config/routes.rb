Rails.application.routes.draw do

  root "pages#home"

  resources :exclusives, :leads, :clients

  get "/connect" => "exclusives#connect"

  get "/upload" => "leads#upload"
  get "/upload_design" => "leads#upload_design"
  get "/upload_development" => "leads#upload_development"


  get "/successful" => "pages#successful_sign_up"
  get "/successful_feedback" => "pages#successful_feedback"
  get "/successful_order" => "pages#successful_order"
  get "/successful_featured" => "exclusives#success"
  get "/onboard" => "leads#onboard"

  # Referral Sales Pages
  get 'c/:coupon' => 'pages#home'
  get '/pjrvs', to: redirect('c/pjrvs')
  get '/obie', to: redirect('c/obie')
  get '/brennan', to: redirect('c/brennan')
  get '/jfdi', to: redirect('c/jfdi')

  get '*path' => redirect('/')
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
