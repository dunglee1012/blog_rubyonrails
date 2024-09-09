class RemoveImageFromArticles < ActiveRecord::Migration[7.2]
  def change
    remove_column :articles, :image, :string
  end
end
