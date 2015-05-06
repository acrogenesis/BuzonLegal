class Tribunal < ActiveRecord::Base
  belongs_to :state
  has_many :cases
end
