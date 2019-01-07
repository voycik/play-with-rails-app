# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Editing an article' do
  before do
    john = User.create(email: "john@rambo.com", password: "qwerty")
    login_as(john)
    @article = Article.create(title: 'First article', body: 'Lorem ipsum', user: john)
  end

  scenario 'User updates an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Updated title'
    fill_in 'Body', with: 'Updated body'
    click_button 'Update Article'

    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'User fails to update an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Updated body'
    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end
