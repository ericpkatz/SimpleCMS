require 'spec_helper'

describe Content do
  before do
    @content = FactoryGirl.build :content
  end

  describe 'Without a title' do
    before do
      @content.title = ''
    end
    it 'Is not valid' do
      expect(@content.valid?).to eq(false)
    end
  end
  describe 'Without a priority' do
    before do
      p @content
      @content.priority = nil
    end
    it 'Is not valid' do
      expect(@content.valid?).to eq(false)
    end
  end
end
