Rails.application.routes.draw do
  resources :libraries
  resources :categories  
  resources :members
  resources :issue_histories
  resources :books
end
