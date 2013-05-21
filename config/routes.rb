ThurgoodApi::Application.routes.draw do

  namespace :v1 do

    get 'jobs/by_user/:user_id', to: 'jobs#by_user'

    resources :jobs, only: [:index, :create, :show]

    put 'jobs/:id/submit',                to: 'jobs#submit'
    get 'jobs/:id/resubmit',              to: 'jobs#resubmit'
    get 'jobs/:id/server',                to: 'jobs#server'
    get 'jobs/:id/logger',                to: 'jobs#logger_system'
    post 'jobs/:id/message',               to: 'jobs#message'

    get 'servers/reserved',               to: 'servers#by_status', :status => 'reserved'
    get 'servers/available',              to: 'servers#by_status', :status => 'available'

    resources :servers, only: [:index, :show]

    get 'servers/:id/release',            to: 'servers#release' # not yet implemented

    post 'loggers/account/create',        to: 'loggers#account_create'
    post 'loggers/system/create',         to: 'loggers#system_create'
    get  'loggers/account/:id',           to: 'loggers#account_show'
    get  'loggers/account/:id/systems',   to: 'loggers#account_systems'
    get  'loggers/system/:id',            to: 'loggers#system_show'
    delete 'loggers/account/:id',         to: 'loggers#account_delete'
    delete 'loggers/system/:id',          to: 'loggers#system_delete'

  end

  mount_sextant if Rails.env.development? # https://github.com/schneems/sextant

end
