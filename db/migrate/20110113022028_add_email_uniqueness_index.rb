class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :uniqueness => true
  end

  def self.down
    remove_index :user, :email
  end
end
