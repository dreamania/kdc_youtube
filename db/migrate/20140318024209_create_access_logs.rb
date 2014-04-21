class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.references :user
      t.string :device
      t.string :ip
      t.string :referer

      t.timestamps
    end
  end
end
