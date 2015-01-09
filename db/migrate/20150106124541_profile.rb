class Profile < ActiveRecord::Migration
  def change

    create_table :consumers do |t|
      t.string   :name,            null: false
      t.timestamps
    end
    create_table :users do |t|
      t.integer  :consumer_id,     null: false
      t.string   :name,            null: false
      t.timestamps
    end

    create_table :uploads do |t|
      t.integer  :consumer_id,     null: false
      t.integer  :tag_id,          null: false
      t.integer  :user_id,         null: false
      t.string   :claim_check,     null: false
      t.string   :upload_type,     null: false
      t.string   :status,          null: false

      t.timestamps
    end

    create_table :matches do |t|
      t.integer  :upload_id,       null: false
      t.integer  :tag_id,          null: false  # denormalized upload tag
      t.integer  :external_id,     null: false
      t.integer  :graydon_id,      null: false
      t.string   :graydon_name,    null: false
      t.decimal  :reliability,     null: false
      t.boolean  :matched,         null: false, default: false

      t.timestamps
    end
    add_index :matches, [:tag_id, :graydon_id, :matched] # for combining organizations based on a tag with the external ID during that particular upload

    create_table :organizations do |t|
      t.integer  :consumer_id,   null: false
      t.integer  :graydon_id,    null: false

      t.timestamps
    end
    add_index :organizations, [:graydon_id, :consumer_id], unique: true

    create_table :organizations_tags do |t|
      t.integer  :organization_id,   null: false
      t.integer  :tag_id,   null: false
    end
    add_index :organizations_tags, [:organization_id, :tag_id], unique: true

    create_table :tags do |t|
      t.string   :name,            null: false
      t.string   :nature,          null: false # reserved, upload, search, folder
      t.integer  :consumer_id
      t.integer  :parent_id
      t.string   :description

      t.timestamps
    end
    add_index :tags, [:consumer_id, :name], unique: true

  end
end
