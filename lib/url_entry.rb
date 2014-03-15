require_relative "url_adapter"

class UrlEntry
  attr_reader :original_url

  def initialize(original_url)
    @original_url = original_url
  end

  def save
    adapter_entry = UrlAdapter.first_or_create(:original_url => original_url)
    adapter_entry.id.to_s(36)
  end

  def self.find(shortened)
    id = shortened.to_i(36)
    adapter_entry = UrlAdapter.get(id)
    UrlEntry.new(adapter_entry.original_url) if adapter_entry
  end
end