class CreateBits < ActiveRecord::Migration
  def change
    create_table :bits do |t|
      t.string :title
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
