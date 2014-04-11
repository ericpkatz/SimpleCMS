require 'spec_helper'

describe Page do

  describe 'Page with contents' do
    before do
      @page = FactoryGirl.create(:page, :with_contents, content_count: 3)
    end

    it 'Has content items' do
      expect(@page.contents.size).to eq(3) 
    end

    it 'Can not be deleted' do
      expect{@page.destroy}.to raise_error
    end
  end
end
