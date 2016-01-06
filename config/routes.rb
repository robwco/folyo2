Rails.application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :leads do
    patch :favorite, on: :member
  end

  resources :exclusives, :leads, :workers, :sales, :products, :prospects, :rfps, :subscriptions, :plans, :rss

  mount StripeEvent::Engine => '/stripe-events'

  # Onboarding
  get "/welcome" => "subscriptions#welcome", as: :welcome
  get "/address" => "subscriptions#address"
  
  # Testing Emails
  get "/test_emails" => "subscriptions#test_email"
  get "/send_emails" => "subscriptions#send_email"
  get "/test_weekly_emails" => "subscriptions#test_weekly_emails"
  get "/send_weekly_emails" => "subscriptions#send_weekly_emails"

  # Plans and Billing
  put "/plans/archive/:id" => "plans#archive", as: :archive_plan
  get "/imports/plans" => "imports#plans", as: :import_plans
  post "/imports/import_plans" => "imports#import_plans", as: :save_imported_plans
  get "/imports/customers" => "imports#customers", as: :import_customers
  post "/imports/import_customers" => "imports#import_customers", as: :save_imported_customers
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

  # Sign in
  root to: redirect("/leads")
  get "/admins/welcome" => "admins#welcome", as: :admin_root
  
  # Email actions
  get "/categories/confirmed" => "subscriptions#updated_categories_confirmed", as: :subscription_categories_save_confirmation
  get "/subscriptions/milestones" => "subscriptions#milestones", as: :update_subscription_milestones
  put "/subscriptions/milestones_save" => "subscriptions#milestones_save", as: :subscription_milestones_save

  # Exclusive Leads
  get "/preview" => "exclusives#preview"
  get "/connect" => "exclusives#connect"
  get "/build" => "exclusives#build"
  
  # Leads
  get "/favorites" => "leads#favorites"
  put "/contacted" => "leads#contacted", as: :contacted


  devise_scope :user do 
      match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
  
  devise_scope :admin do 
      match '/sessions/admin', to: 'devise/sessions#create', via: :post
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
