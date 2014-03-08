require 'spec_helper'

describe Offer, '#retrieve_offers' do
  it 'should crawl the API and create offers in the database' do
    Offer.retrieve_offers
    expect(Offer.all.count).to eq 20
  end  

  it 'should crawl the API multiple times and not create duplicate offers' do
    Offer.retrieve_offers
    Offer.retrieve_offers
    expect(Offer.all.count).to eq 20
  end  
end  
