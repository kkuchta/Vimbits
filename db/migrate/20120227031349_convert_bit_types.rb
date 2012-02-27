class ConvertBitTypes < ActiveRecord::Migration
  def up
    change_table :bits do |t|
      t.change :code, :text, limit: nil
      t.change :description, :text, limit:nil
    end
  end

  def down
    change_table :bits do |t|
      t.change :code, :string
      t.change :description, :string
    end
  end
end
