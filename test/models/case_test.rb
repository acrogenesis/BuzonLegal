# == Schema Information
#
# Table name: cases
#
#  id          :integer          not null, primary key
#  date        :datetime
#  casenumber  :string
#  description :text
#  tribunal_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
