require 'spec_helper'

feature 'Visit /offers page' do
  scenario 'while not pressing the crawl button' do
    visit offers_path
    expect(Offer.all.count).to eq 0
    expect(page).to have_css 'h1', text: '0 Offers'
  end
  scenario 'while pressing the crawl button once' do
    visit offers_path
    click_button 'Crawl!'
    expect(Offer.all.count).to eq 20
    expect(page).to have_css 'h1', text: '20 Offers'
  end
  scenario 'while pressing the crawl button multiple times' do
    visit offers_path
    click_button 'Crawl!'
    click_button 'Crawl!'
    expect(Offer.all.count).to eq 20
    expect(page).to have_css 'h1', text: '20 Offers'
  end
end  
