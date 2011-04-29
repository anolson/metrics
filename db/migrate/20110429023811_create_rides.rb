class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
      t.string :name
      t.string :strava_url
      t.float :normalized_power
      t.float :training_stress_score
      t.float :intensity_factor
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rides
  end
end
