class Page < ActiveRecord::Base
  has_many :contents
  before_destroy do
    if Page.all.size == 1
      false
    end
    if self.is_home_page_was
      Page.where("id <> ?", self.id).first.update_columns(is_home_page: true)
    end
  end

  after_save do
    if self.is_home_page
      others = Page.where("id <> ?", self.id)
      others.each do |page|
        page.update_columns(is_home_page: false)
      end
    elsif self.is_home_page_was
      Page.where("id <> ?", self.id).first.update_columns(is_home_page: true)
    end
  end

  before_save do |page|
    if self.is_home_page_was && !self.is_home_page && Page.count == 1
      false
    end
  end
end
