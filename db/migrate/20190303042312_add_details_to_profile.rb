class AddDetailsToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :city, :string
    add_column :profiles, :address, :string
    add_column :profiles, :about, :text
    add_column :profiles, :postal_code, :string
  end
end
