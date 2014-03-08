class Offer < ActiveRecord::Base
  belongs_to :merchant
  validates_uniqueness_of :id
  DEVELOPER_KEY = '00853007dc51e2bd4d3d139cbd8d387b1c3d9cae8afd4cef2a8c5add85d2808d34cf17e3303197fc22fbbd5ec4467b40c244f99035561789932878bdcf14ef7b67/1faecb4fe7d2ce415f7418e7267ef71a42b5d0f7934607e6d1389455cf3b715b70892b0ec2da8136c8bff4ab91ebcfec466caf8eacfd7d16a4ffe42e935cc0a1' 
  WEBSITE_ID = '5742006' 

  def self.retrieve_offers
    cj = CommissionJunction.new(DEVELOPER_KEY, WEBSITE_ID)
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
