Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'welcome#home'
get 'about', to: 'welcome#about'

resources :articles
get 'signup', to: 'users#new'
resources :users , except: [:new]

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

resources :categories, except: [:destroy]

get 'my_friends', to: 'users#my_friends'
resources :users, only:[:show]
resources :friendships

get 'search_friends', to: 'users#search'
get 'add_friend', to: "users#add_friend"

end
