class RemoveIpAddressesFromUrl < ActiveRecord::Migration[5.0]
  def change
    remove_column :urls, :ip_addresses, :text
  end
end
