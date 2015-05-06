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

class Case < ActiveRecord::Base
  belongs_to :tribunal
end
