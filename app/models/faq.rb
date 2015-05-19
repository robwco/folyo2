class Faq < ActiveRecord::Base
  has_ancestry
  
	scope :most_recently_updated, -> { order("updated_at desc")}
  scope :workshop, -> { where("category like '%Workshop%'") }
  validates :anchor, uniqueness: true, presence: true
  
  def to_param
    anchor
  end
end
