require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association Test
  # check model relationship with Item model
  it { should belong_to(:todo) }
  
  # Validation Test
  # check column availability
  it { should validate_presence_of(:name) }
end
