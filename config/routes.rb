Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments
    collection do
      # get 'public_and_private'
      # get 'archived'
      get 'active_article', to: 'articles#active_article'
      get 'archived_article', to: 'articles#archived_article'
    end
  end
end
