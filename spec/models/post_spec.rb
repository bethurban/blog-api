require 'rails_helper'

RSpec.describe Post, type: :model do
  #Association test - make sure Post belongs to single Blog instance
  it { should belong_to(:blog) }

  #Validation tests - make sure title and content columns are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  
end
