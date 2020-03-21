Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :game_teams, only: [:create, :update]
    resources :word_games, only: [:update]
  end
end
