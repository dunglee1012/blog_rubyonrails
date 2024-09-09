class AddImageToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :image, :string
  end
end
