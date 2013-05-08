ThurgoodApi::Application.routes.draw do

  namespace :v1 do

  	get 'jobs/by_email/:email', to: 'jobs#by_email', :constraints => { :email => /.+@.+\..*/ }
    resources :jobs, only: [:index, :create, :show]
    get 'jobs/:id/submit', to: 'jobs#submit'

  	get 'servers/reserved', to: 'servers#by_status', :status => 'reserved'
  	get 'servers/available', to: 'servers#by_status', :status => 'available'
    resources :servers, only: [:index, :show]
    get 'servers/:id/release', to: 'servers#release'

    post 'loggers/account/create', to: 'loggers#account_create'
    post 'loggers/system/create', to: 'loggers#system_create'

  end

  mount_sextant if Rails.env.development? # https://github.com/schneems/sextant

end
