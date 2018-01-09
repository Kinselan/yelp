class Business < ActiveRecord::Base
  # include Sluggable
  validates_presence_of :name, :address, :telephone

  has_many :reviews

  # sluggable_column :name
  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.name.gsub(' ', '-').downcase
    # self.save
  end
end
