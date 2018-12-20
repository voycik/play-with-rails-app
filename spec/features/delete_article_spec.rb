# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Delete an article' do
  before do
    @article = Article.create(title: 'First article', body: 'Lorem ipsum')
  end

  scenario 'User deletes an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(articles_path)
  end
end
