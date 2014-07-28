class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :character_name
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :wis
      t.integer :int
      t.integer :cha
      t.string :character_race
      t.string :character_class
      t.string :character_alignment
      t.integer :armor_bonus
      t.integer :shield_bonus
      t.integer :fort_save
      t.integer :ref_save
      t.integer :will_save
      t.integer :base_attack_bonus
      t.integer :nat_armor
      t.integer :character_size

      t.timestamps
    end
  end
end
