Rails.application.routes.draw do

  resources :messages do
    put "archive", on: :member
  end

  resources :replies do
	  get "without_user", on: :collection
	  get "complete", on: :collection
	  get "preview", on: :member
	  put "post", on: :member
	  resources :messages
  end

  resources :projects do
    get "home", on: :collection
    get "company", on: :collection
    get "thank_you", on: :collection
    get "tour", on: :collection
    get "active", on: :collection
    get "yours", on: :collection
    get "inbox", on: :collection
    get "publish", on: :collection
    get "preview", on: :member
    get "payment", on: :member
    put "select_payment", on: :member
    get "collect_payment", on: :member
    put "charge_payment", on: :member

    resources :replies do
      get 'new_user', on: :new
    end
    resources :wizard, controller: :project_steps
  end

  resources :products

  devise_for :admins
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :leads do
    patch :favorite, on: :member
    get :favorite, on: :member
  end

  mount StripeEvent::Engine => '/stripe-events'

  # Post a project marketing
  get "/choose-project-type" => "projects#portal"
  
  # New account differences 
  get "/pro-signup" => "subscriptions#new_pro"
  get "/account-type" => "subscriptions#new_account_type", as: :account_type
  put "/update-account-type/:type" => "subscriptions#update_account_type", as: :update_account_type
  get "/finish-reply" => "subscriptions#new_finish_reply"
  get "/freelancer-details" => "subscriptions#freelancer", as: :freelancer_details
  put "/freelancer-details" => "subscriptions#update_freelancer", as: :update_freelancer_details

  
  # Onboarding
  get "/tour/attract" => "tour#writing"
  get "/tour/great-responses" => "tour#responses"
  
  # Testing Emails
  get "/test_emails" => "subscriptions#test_email"
  get "/send_emails" => "subscriptions#send_email"
  get "/test_weekly_emails" => "subscriptions#test_weekly_emails"
  get "/send_weekly_emails" => "subscriptions#send_weekly_emails"

  # Plans and Billing
  put "/plans/archive/:id" => "plans#archive", as: :archive_plan
  get "/subscriptions/upgrade_plan" => "subscriptions#upgrade_plan", as: :upgrade_plan
  post "/subscriptions/upgrade_save" => "subscriptions#upgrade_save", as: :upgrade_save
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
  get "/subscriptions/choose" => "subscriptions#choose", as: :choose_subscription

  # Sign in
  root to: redirect("/projects/home")
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
  put "/need_to_email" => "leads#need_to_email", as: :need_to_email
  put "/contacted" => "leads#contacted", as: :contacted
  put "/responded" => "leads#responded", as: :responded
  put "/touch_base" => "leads#touch_base", as: :touch_base

  devise_scope :user do 
      match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
  
  devise_scope :admin do 
      match '/sessions/admin', to: 'devise/sessions#create', via: :post
  end

  resources :exclusives, :leads, :workers, :sales, :products, :prospects, :rfps, :subscriptions, :plans

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
