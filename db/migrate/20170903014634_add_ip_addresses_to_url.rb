class AddIpAddressesToUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :ip_addresses, :string, array:true, default: '{}'
  end
end
