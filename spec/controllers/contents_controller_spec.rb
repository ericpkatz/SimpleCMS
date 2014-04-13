require 'spec_helper'

describe ContentsController do

  describe 'Create' do

    describe 'A valid page' do
      before do
        @content = FactoryGirl.build :content
        attr = @content.attributes.slice("title", "body", "priority", "page_id")
        post :create, content: attr 

      end

      it 'creates a page' do
        content = JSON.parse response.body
        expect(content["title"]).to eq @content.title
      end
    end

  end

  describe 'Update' do

    describe 'A valid page' do
      before do
        page = FactoryGirl.create :page
        @content = FactoryGirl.create :content, page_id: page.id
        attr = @content.attributes.slice("title", "body", "priority", "page_id")
        put :update, id: @content.id, content: attr 

      end

      it 'Updates a page' do
        content = JSON.parse response.body
        expect(content["title"]).to eq @content.title
      end
    end

  end

  describe 'Delete' do

    describe 'A valid page' do
      before do
        page = FactoryGirl.create :page
        @content = FactoryGirl.create :content, page_id: page.id
        attr = @content.attributes.slice("title", "body", "priority", "page_id")
        delete :destroy, id: @content.id, content: attr 

      end

      it 'Removes the page' do
        content = JSON.parse response.body
        expect(content["success"]).to eq true 
      end
    end

  end

end

