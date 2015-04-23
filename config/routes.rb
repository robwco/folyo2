Rails.application.routes.draw do
  devise_for :users
  resources :people

  root "pages#home"

  resources :exclusives, :leads, :workers, :sessions, :sales, :products, :prospects, :rfps, :faqs
  
  get "/connect" => "exclusives#connect"
  get "/build" => "exclusives#build"
  
  get "/popular" => "pages#popular_resources"

  get "/work" => "workers#work"
  get "/settings" => "workers#settings"

  get "/upload" => "leads#upload"
  get "/upload_design" => "leads#upload_design"
  get "/upload_development" => "leads#upload_development"

  get "/thanks" => "pages#successful_generic"
  get "/successful" => "pages#successful_sign_up"
  get "/successful_feedback" => "pages#successful_feedback"
  get "/successful_order_etw" => "pages#successful_order_etw"
  get "/successful_order_workshop" => "pages#successful_order_workshop"
  get "/successful_featured" => "exclusives#success"
  
  get "/people" => "pages#people.html.erb"
  get "/start" => "pages#start.html.erb"
  
  # Resources
  get "/freelance-as-a-service" => "pages#freelance-as-a-service"
  get "/the-email-line" => "pages#the-email-line"
  get "/advice" => "pages#advice"
  get "/help" => "pages#help"
  get "/freelance-tools" => "pages#tools"
  get "/feedback" => "pages#feedback"
  get "feedback/client" => "pages#clientfeedback"
  
  # Sandbox
  get "/wheelhouse" => "pages#wheelhouse"

  # Referral Sales Pages
  get "/copyhackers" => "pages#copyhackers"
  get "/freelancer-association/workshop" => "pages#webinar"
  get "/freelancer-association" => "pages#fa-webinar"

  # Payments
  get  '/buy/:permalink', to: 'transactions#new',      as: :show_buy
  post '/buy/:permalink', to: 'transactions#create',   as: :buy
  get  '/pickup/:guid',   to: 'transactions#pickup',   as: :pickup
  get  '/download/:guid', to: 'transactions#download', as: :download
  
  get "/dyfc" => "pages#dyfc"
  get "/using-job-boards" => "pages#dyfc-worksheet"
  get "/worksheet" => "pages#dyfc-worksheet"
  get 'c/:coupon' => 'pages#home'
  get '/pjrvs', to: redirect('c/pjrvs')
  get '/obie', to: redirect('c/obie')
  get '/brennan', to: redirect('c/brennan')
  get '/jfdi', to: redirect('c/jfdi')
  get '/2015', to: redirect('c/2015')

  devise_scope :user do 
      match '/sessions/user', to: 'devise/sessions#create', via: :post
  end

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
