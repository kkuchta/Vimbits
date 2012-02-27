class ConvertBitTypes < ActiveRecord::Migration
  def up
    change_table :bits do |t|
      t.change :code, :text, limit: 5000
      t.change :description, :text, limit:5000
    end
  end

  def down
    change_table :bits do |t|
      t.change :code, :string
      t.change :description, :string
    end
  end
end
