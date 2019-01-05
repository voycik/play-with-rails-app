# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Delete an article' do
  before do
    john = User.create(email: "john@rambo.com", password: "qwerty")
    login_as(john)
    @article = Article.create(title: 'First article', body: 'Lorem ipsum', user: john)
  end

  scenario 'User deletes an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(articles_path)
  end
end
