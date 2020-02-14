class CreateReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :references do |t|
      t.integer :referred_id
      t.integer :referral_id

      t.timestamps
    end
  end
end
