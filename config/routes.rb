Rails.application.routes.draw do
  resources :sales

  resources :products

  devise_for :users
  resources :prospects

  resources :rfps

  resources :faqs

  root "pages#home"

  resources :exclusives, :leads, :workers, :sessions

  # get 'login', to: 'sessions#new', as: 'login'
  # get 'logout', to: 'sessions#destroy', as: 'logout'
  devise_scope :user do 
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
  
  get "/connect" => "exclusives#connect"
  get "/popular" => "pages#popular_resources"

  get "/work" => "workers#work"
  # get "/login" => "sessions#new"

  get "/upload" => "leads#upload"
  get "/upload_design" => "leads#upload_design"
  get "/upload_development" => "leads#upload_development"

  get "/thanks" => "pages#successful_generic"
  get "/successful" => "pages#successful_sign_up"
  get "/successful_feedback" => "pages#successful_feedback"
  get "/successful_order" => "pages#successful_order"
  get "/successful_featured" => "exclusives#success"
  get "/onboard" => "leads#onboard"

  # Blog Articles
  get "/freelance-as-a-service" => "pages#freelance-as-a-service"
  get "/the-email-line" => "pages#the-email-line"
  
  get "/advice" => "pages#help"
  
  # Sandbox
  get "/wheelhouse" => "pages#wheelhouse"

  # Referral Sales Pages
  get "/copyhackers" => "pages#copyhackers"
  get "/dyfc" => "pages#dyfc"
  get 'c/:coupon' => 'pages#home'
  get '/pjrvs', to: redirect('c/pjrvs')
  get '/obie', to: redirect('c/obie')
  get '/brennan', to: redirect('c/brennan')
  get '/jfdi', to: redirect('c/jfdi')
  get '/2015', to: redirect('c/2015')

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
