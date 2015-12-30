Rails.application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :people
  
  resources :leads do
    patch :favorite, on: :member
  end
  
  mount StripeEvent::Engine => '/stripe-events'

  # Onboarding
  get "/address" => "subscriptions#address"
  get "/what-makes-a-good-lead" => "subscriptions#good_lead"
  get "/how-favorites-work" => "subscriptions#favorite_tutorial"

  get "/processing" => "rss#processing"
  get "/rss/hide" => "rss#hide"
  get "/rss/unhide" => "rss#unhide"
  get "/rss/approve" => "rss#approve"

  get "/approved_links" => "approved_links#index"
  get "/approved_links/hide" => "approved_links#hide"
  get "/approved_links/unhide" => "approved_links#unhide"
  
  get "/folyo_test" => "subscriptions#folyo"
  get "/test_emails" => "subscriptions#test_email"
  get "/send_emails" => "subscriptions#send_email"

  get "/imports/plans" => "imports#plans", as: :import_plans
  post "/imports/import_plans" => "imports#import_plans", as: :save_imported_plans
  get "/imports/customers" => "imports#customers", as: :import_customers
  post "/imports/import_customers" => "imports#import_customers", as: :save_imported_customers

  root to: redirect("/users/edit")

  get "/welcome" => "subscriptions#welcome", as: :welcome
  get "/welcome_next_step" => "subscriptions#welcome_next_step"
  get "/admins/welcome" => "admins#welcome", as: :admin_root
  get "/subscriptions/upgrade_plan" => "subscriptions#upgrade_plan", as: :upgrade_plan
  put "/subscriptions/upgrade_save" => "subscriptions#upgrade_save", as: :upgrade_save
  get "/subscriptions/cancel" => "subscriptions#cancel", as: :cancel_subscription
  get "/subscriptions/cancel_by_email" => "subscriptions#cancel_by_email", as: :cancel_subscription_by_email
  post "/subscriptions/cancel" => "subscriptions#cancel_post", as: :cancel_subscription_post
  post "/subscriptions/cancel_leads_followup" => "subscriptions#cancel_leads_followup", as: :cancel_subscription_leads_followup
  delete "/subscriptions/destroy" => "subscriptions#destroy", as: :destroy_subscription
  get "/subscriptions/creditcard" => "subscriptions#creditcard", as: :update_subscription_creditcard
  put "/subscriptions/creditcard_save" => "subscriptions#creditcard_save", as: :subscription_creditcard_save
  put "/subscriptions/reactivate" => "subscriptions#reactivate", as: :reactivate_subscription
  get "/subscriptions/categories" => "subscriptions#categories", as: :update_subscription_categories
  put "/subscriptions/categories_save" => "subscriptions#categories_save", as: :subscription_categories_save
  
  get "/categories/confirmed" => "subscriptions#updated_categories_confirmed", as: :subscription_categories_save_confirmation
  
  get "/subscriptions/milestones" => "subscriptions#milestones", as: :update_subscription_milestones
  put "/subscriptions/milestones_save" => "subscriptions#milestones_save", as: :subscription_milestones_save

  resources :exclusives, :leads, :workers, :sales, :products, :prospects, :rfps, :subscriptions, :plans, :rss

  put "/plans/archive/:id" => "plans#archive", as: :archive_plan


  get "/preview" => "exclusives#preview"
  get "/connect" => "exclusives#connect"
  get "/build" => "exclusives#build"
  
  get "/popular" => "pages#popular_resources"

  get "/work" => "workers#work"
  get "/settings" => "workers#settings"

  get "/feeds" => "rss#feeds"

  get "/all" => "leads#all"
  get "/favorites" => "leads#favorites"
  get "/upload" => "leads#upload"
  get "/upload_design" => "leads#upload_design"
  get "/upload_development" => "leads#upload_development"

  get "/thanks" => "pages#successful_generic"
  get "/successful" => "pages#successful_sign_up"
  get "/successful_feedback" => "pages#successful_feedback"
  get "/successful_order_etw" => "pages#successful_order_etw"
  get "/successful_order_workshop" => "pages#successful_order_workshop"
  get "/successful_featured" => "exclusives#success"
  
  get "/rigbooks" => "pages#rigbooks"
  
  get "/tyler" => "pages#tyler"
  get "/freelancing" => "pages#course"
  
  get "/people" => "pages#people.html.erb"
  get "/start" => "pages#start.html.erb"
  get "/pricing" => "pages#pricing.html.erb"
  
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
  devise_scope :admin do 
      match '/sessions/admin', to: 'devise/sessions#create', via: :post
  end

  
  resources :faqs, only: [:index, :new, :create]
  resources :faqs, path: "", except: [:index, :new, :create]

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
