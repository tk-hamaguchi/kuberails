class CreateKuberailsResources < ActiveRecord::Migration[6.0]
  def change
    create_table :kuberails_resources do |t|
      t.string :type,          null: false
      t.text   :yaml
      t.string :entity_type,   null: false
      t.string :resource_name, null: false
      t.string :namespace,     null: false
      t.string :name,          null: false
      t.string :uri

      t.timestamps
    end

    add_index :kuberails_resources, %i[namespace resource_name name],
              name: 'unique_index_for_kuberails_resources', unique: true
  end
end
