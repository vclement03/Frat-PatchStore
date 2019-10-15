class EnableUuidExtension < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    add_column :orders, :uuid, :uuid, default: "uuid_generate_v4()"
  end
end
