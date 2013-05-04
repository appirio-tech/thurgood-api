ThurgoodApi::Application.routes.draw do

  namespace :v1 do

    resources :servers

  end

  mount_sextant if Rails.env.development? # https://github.com/schneems/sextant

end
