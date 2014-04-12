require 'spec_helper'

describe PagesController do

  describe "CREATE" do
    before do
      @page = FactoryGirl.build :page, :low_priority
    end
    it 'Creates a page' do
      post :create, format:'json', page: @page.attributes
      page = JSON.parse response.body
      expect(page["priority"]).to eq(@page.priority)
    end
  end

  describe "/page/" do
    before do
      @page = FactoryGirl.create :page, :with_contents, content_count: 2 
    end
    it 'Creates a page' do
      get :show, format: 'json', id: @page.id
      page = JSON.parse response.body
      expect(page["contents"].count).to eq(2)
    end
  end
end
