class AddSessionToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :session, :string
  end
end
