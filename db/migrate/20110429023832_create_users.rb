class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :strava_athlete_id
      t.string :strava_api_token
      t.integer :threshold_power
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
