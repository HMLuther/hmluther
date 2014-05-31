class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :item
      t.boolean   :active, :default => true
      t.boolean   :banner, :default => false
      t.string    :image_type
      t.integer   :position
      t.boolean   :primary, :default => false
      t.boolean   :thumb, :default => false
      t.string    :url
      t.boolean   :webcomp, :default => false

      t.timestamps
    end
    add_index(:images, :item_id)
  end
end
