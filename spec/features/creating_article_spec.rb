# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Creating Articles' do
  scenario 'A user creates a new article' do
    visit '/'
    click_link 'New article'
    fill_in 'Title', with: 'First article'
    fill_in 'Body', with: 'Lorem ipsum'
    click_button 'Create Article'
    expect(page).to have_content('Article has been created')
    expect(page.current_path).to eq(articles_path)
  end

  scenario 'A user fails to create a new article' do
    visit '/'
    click_link 'New article'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Create Article'
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
