class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
      t.string  :name
      t.datetime  :date
      t.integer :strava_ride_id
      t.float   :normalized_power,      :default => 0.0
      t.float   :training_stress_score, :default => 0.0
      t.float   :intensity_factor,      :default => 0.0
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rides
  end
end
