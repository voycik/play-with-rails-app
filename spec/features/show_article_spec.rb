# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Showing an article' do
  before do
    @john = User.create(email: "john@rambo.com", password: "qwerty")
    @chris = User.create(email: "chris@mail.com", password: "asdfgh")

    @article = Article.create(title: 'First article', body: 'Lorem ipsum', user: @john)
  end

  scenario 'To non-signed user hide edit and delete button' do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'To non-owners hide edit and delete button' do
    login_as(@chris)
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")

  end
end
