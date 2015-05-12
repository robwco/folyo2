class Faq < ActiveRecord::Base
  scope :workshop, -> { where("category like '%Workshop%'") }
  validates :anchor, uniqueness: true, presence: true
  
  def to_param
    anchor
  end
end
