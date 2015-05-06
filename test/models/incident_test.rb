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

require 'test_helper'

class IncidentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
