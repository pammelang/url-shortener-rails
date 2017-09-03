require 'socket'
class Url < ApplicationRecord

  attribute :original_url, :string
  attribute :short_url, :string
  attribute :clicks, :integer, :default => 0

  before_create :create_short_url
  before_create :sanitize_original_url

  validates :original_url, presence: true

  def create_short_url
    chars = ['0'..'9', 'a'..'z', 'A'..'Z'].map {|i| i.to_a}.flatten

    self.short_url = 6.times.map {chars.sample}.join until
    Url.find_by_short_url(self.short_url).nil?
  end

  def sanitize_original_url
    original = self.original_url.gsub(/(https?:\/{2})|(www\.)/, '')
    self.original_url = "http://" + original
  end
end
