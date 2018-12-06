Rails.application.routes.draw do

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy


  # Authentication routes





  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :officers
  resources :units
  resources :investigations
  resources :crimes
  resources :users

  # Routes for assignments and other customs
  get 'assignments/new', to: 'assignments#new', as: :new_assignment
  post 'assignments', to: 'assignments#create', as: :assignments
  patch 'assignments/:id/terminate', to: 'assignments#terminate', as: :terminate_assignment

  get 'suspects/new', to: 'suspects#new', as: :new_suspect
  post 'suspects', to: 'suspects#create', as: :suspects
  patch 'suspects/:id/terminate', to: 'suspects#terminate', as: :terminate_suspect

  get 'crime_investigations/new', to: 'crime_investigations#new', as: :new_crime_investigation
  post 'crime_investigations', to: 'crime_investigations#create', as: :crime_investigations

  get 'investigation_notes/new', to: 'investigation_notes#new', as: :new_investigation_note
  post 'investigation_notes' to: 'investigation_notes#create' as: :investigation_notes

  # Toggle paths




  # Other custom routes




  # Routes for searching




  # You can have the root of your site routed with 'root'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
