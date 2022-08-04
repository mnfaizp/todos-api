require 'rails_helper'

RSpec.describe Todo, type: :model do
  # Association Test
  # check model relationship with Item model
  it { should have_many(:items).dependent(:destroy) }
  
  # Validation Test
  # check column availability
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
