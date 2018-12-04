Rails.application.routes.draw do
  #resources :sales
  get 'sales/new'
  post 'sales', to: 'sales#create'
  get 'sales/done'
  get 'sales/index'
  delete 'sales/:id', to: 'sales#destroy', as: 'sale_destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
