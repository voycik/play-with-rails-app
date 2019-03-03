# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Articles', type: :request do
  before do
    @john = User.create(email: 'john@rambo.com', password: 'qwerty')
    @fred = User.create(email: 'fred@durst.com', password: 'rolling')
    @article = Article.create!(title: 'Title one', body: 'Body of article one', user: @john)
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }
      it 'handles existing article' do
        expect(response.status).to eq 200
      end
    end
    context 'with non-existing article' do
      before { get '/articles/xxxxx' }
      it 'handles non-existing article' do
        expect(response.status).to eq 302
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
#edit
  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before {get "/articles/#{@article.id}/edit"}
      it "redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in users who are non-owners' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end
      it "redirects to the show article page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in users who are owners' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end
      it "succefully edits article" do
        expect(response.status).to eq 200
      end
    end
  end
#Delete
  describe 'DELETE /articles/:id' do
    context 'with non-signed in user' do
      before {delete "/articles/#{@article.id}"}
      it "redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in users who are non-owners' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"

      end
      it "redirects to the show article page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article."
        expect(flash[:danger]).to eq flash_message
      end
    end

    context 'with signed in users who are owners' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end
      it "succefully deletes article" do
        expect(response.status).to eq 302
        flash_message = 'Article has been deleted'
        expect(flash[:success]).to eq flash_message
      end
    end
  end
end
