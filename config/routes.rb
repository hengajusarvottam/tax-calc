Rails.application.routes.draw do
  resources :taxes
  root to: 'taxes#new'
end
