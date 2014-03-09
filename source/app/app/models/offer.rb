class Offer < ActiveRecord::Base
  belongs_to :merchant
  validates_uniqueness_of :id

  def self.retrieve_offers
    cj = CommissionJunction.new(APP_CONFIG['developer_key'], APP_CONFIG['website_id'])
    cj.link_search('keywords' => 'ebooks',
                   'records-per-page' => '20').each do |link|
      Offer.create(id: link.link_id,
                   title: link.link_name,
                   description: link.description,
                   url: link.destination,
                   expires_at: link.promotion_end_date,
                   merchant_id: link.advertiser_id)
      Merchant.create(id: link.advertiser_id,
                      name: link.advertiser_name)
    end  
  end  
end
