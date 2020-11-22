class AddContentToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :content, :string
  end
end
