require 'rails_helper'

RSpec.describe Blog, type: :model do
  # Association test - make sure Blog has a 1:m relationship with Post
  it { should have_many(:items).dependent(:destroy) }

  #Validation tests - make sure title and created_by columns are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
