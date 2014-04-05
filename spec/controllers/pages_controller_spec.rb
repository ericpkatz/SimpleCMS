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

end
