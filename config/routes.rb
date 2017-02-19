Rails.application.routes.draw do

  resources :offerings

  resources :announcements

  resources :messages, except: :show do
    put "archive", on: :member
    put "unarchive", on: :member
  end

  resources :replies do
	  get "without_user", on: :collection
	  get "complete", on: :collection
	  get "preview", on: :member
	  get "message", on: :member
	  put "post", on: :member
	  put "archive", on: :member
    put "unarchive", on: :member
	  resources :messages
  end

  resources :projects do
    get "home", on: :collection
    get "thank_you", on: :member
    get "tour", on: :collection
    #get "active", on: :collection
    #get "yours", on: :collection
    get "inbox", on: :collection
    get "publish", on: :collection
    get "preview", on: :member
    get "payment", on: :member
    put "charge_payment", on: :member
    put "update_status", on: :member
    put "post", on: :member

    put "admin_approve", on: :member
    put "admin_reject", on: :member
    put "admin_destroy", on: :member

    resources :replies do
      get 'new_user', on: :new
    end
  end

  #resources :products
  devise_for :admins
  devise_for :users, :controllers => { registrations: 'registrations' }

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
  get "/client-details" => "subscriptions#client", as: :client_details
  put "/client-details" => "subscriptions#update_client", as: :update_client_details

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
  put "/subscriptions/upgrade_save" => "subscriptions#upgrade_save", as: :upgrade_save
  put "/subscriptions/freelancer_upsell_save" => "subscriptions#freelancer_upsell_save", as: :freelancer_upsell_save
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

  # Marketing pages
  get "about" => "pages#about"
  get "terms" => "pages#terms"
  get "partners" => "pages#partners"
  get "/tour", to: redirect("https://clientgiant.us/the-best-work-of-your-life-beb827df269b#.bh05ybl7r", status: 301)
  get "/guides/how_to_pick_a_great_designer", to: redirect("https://clientgiant.us/how-to-write-a-job-ad-and-attract-the-right-people-to-your-project-9b8dd921e5e8#.vjyjulim6", status: 301)
  get "/guides/how_to_write_a_good_job_description", to: redirect("https://clientgiant.us/how-to-write-a-job-ad-and-attract-the-right-people-to-your-project-9b8dd921e5e8#.vjyjulim6", status: 301)

  # Sign in
  root to: redirect("/projects/home")
  get "/admins/welcome" => "admins#welcome", as: :admin_root
  
  devise_scope :user do 
    match '/sessions/user', to: 'devise/sessions#create', via: :post
    get "/profile/:id" => "registrations#show", as: :profile
  end
  
  devise_scope :admin do 
      match '/sessions/admin', to: 'devise/sessions#create', via: :post
  end

  resources :subscriptions

  #resources :exclusives, :leads, :workers, :sales, :products, :prospects, :rfps, :subscriptions, :plans

  get '*path' => redirect('/') if Rails.env.production?
end
