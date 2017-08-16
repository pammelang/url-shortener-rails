require 'socket'
class Url < ApplicationRecord

  attribute :original_url, :string
  attribute :short_url, :string
  attribute :clicks, :integer, :default => 0
  attribute :ip_address, :string

  before_create :create_short_url
  before_create :get_ip_address
  before_create :sanitize_original_url
  
  validates :original_url, presence: true 

  def create_short_url
    chars = ['0'..'9', 'a'..'z', 'A'..'Z'].map {|i| i.to_a}.flatten

    self.short_url = 6.times.map {chars.sample}.join
  end

  def get_ip_address
    self.ip_address = IPSocket.getaddress('localhost')
#    not working???
  end

  def sanitize_original_url
      original = self.original_url
      if original !=~ /http:\/{2}.+/
        self.original_url = "http://" + original
      end
  end
end
