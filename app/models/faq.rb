class Faq < ActiveRecord::Base
  scope :workshop, -> { where("category like '%Workshop%'") }
end
