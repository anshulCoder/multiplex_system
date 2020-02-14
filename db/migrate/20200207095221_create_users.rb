class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.float :reward_points
      t.string :user_tier
      t.string :referral_code

      t.timestamps
    end
  end
end
