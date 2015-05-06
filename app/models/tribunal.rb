# == Schema Information
#
# Table name: tribunals
#
#  id         :integer          not null, primary key
#  name       :string
#  state_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tribunal < ActiveRecord::Base
  belongs_to :state
  has_many :cases
end
