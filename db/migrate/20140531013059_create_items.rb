class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references  :subcategory
      t.boolean     :active, :default => true
      t.string      :circa
      t.string      :depth
      t.text        :description
      t.string      :description_short
      t.string      :diameter
      t.string      :filemaker_id
      t.string      :height
      t.string      :location
      t.text        :reference
      t.boolean     :sold, :default => false
      t.string      :width

      t.timestamps
    end
    add_index(:items, :filemaker_id)
  end
end
