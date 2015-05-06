# == Schema Information
#
# Table name: incidents
#
#  id          :integer          not null, primary key
#  description :text
#  state_id    :integer
#  public      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Incident < ActiveRecord::Base
  belongs_to :state
end
