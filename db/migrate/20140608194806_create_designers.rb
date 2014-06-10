class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string  :name
      t.text  :bio
      t.boolean :active, :default => true
      t.boolean :include, :default => false
      t.boolean :omit, :default => false
      t.string  :production_date
      t.string  :website
      t.string :filemaker_id
      t.string  :slug

      t.timestamps
    end
    add_index(:designers, :slug)
  end
end
