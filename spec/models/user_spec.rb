require 'rails_helper'

RSpec.describe User, type: :model do

  #Association test - make sure User has a 1:m relationship with Blog
  it { should have_many(:blogs) }

  #Validation tests - make sure name, email, and password_digest are present
  #before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

end
