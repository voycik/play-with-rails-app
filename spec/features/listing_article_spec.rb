require 'rails_helper'
RSpec.feature "Listing articles" do
  before do
    @article1 = Article.create(title: "First article", body: "Lorem ipsum")
    @article2 = Article.create(title: "Second article", body: "W szczebrzeszynie...")
  end

  scenario "A user llists all articles" do
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end
