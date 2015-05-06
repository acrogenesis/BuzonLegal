# == Schema Information
#
# Table name: states
#
#  id               :integer          not null, primary key
#  name             :string
#  online           :boolean          default(TRUE)
#  last_time_online :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class StateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
