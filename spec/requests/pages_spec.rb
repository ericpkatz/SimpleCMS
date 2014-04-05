require 'spec_helper'
require 'json'

describe "Pages" do
  describe "GET /pages" do
    before do
      @home_page = FactoryGirl.create :page, :home_page
      @low_priority = FactoryGirl.create :page, :low_priority 
      @b_high_priority = FactoryGirl.create :page, :high_priority, title: 'bee' 
      @a_high_priority = FactoryGirl.create :page, :high_priority, title: 'ayy'
    end
    it "has a priority" do
      get '/pages.json'
      page = (JSON.parse response.body).first
      expect(page['priority']).to eq(@home_page.priority)
    end
    it "last page has lowest priority" do
      get '/pages.json'
      page = (JSON.parse response.body).last
      expect(page['id']).to eq(@low_priority.id)
    end
    it "the second page should be ayyy" do
      get '/pages.json'
      page = (JSON.parse response.body)[1]
      expect(page['id']).to eq(@a_high_priority.id)
    end
  end

  describe "GET /pages:id" do
    before do
      @home_page = FactoryGirl.create :page, :home_page
      @low_priority = FactoryGirl.create :page, :low_priority 
      @b_high_priority = FactoryGirl.create :page, :high_priority, title: 'bee' 
      @a_high_priority = FactoryGirl.create :page, :high_priority, title: 'ayy'
    end
    it "has a priority" do
      get "/pages/#{@home_page.id}.json"
      page = (JSON.parse response.body)

      expect(page['priority']).to eq(@home_page.priority)
    end
  end
end
