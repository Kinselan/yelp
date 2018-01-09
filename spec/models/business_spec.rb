require 'rails_helper'

describe Business do
  it { should validate_presence_of(:name)      }
  it { should validate_presence_of(:address)   }
  it { should validate_presence_of(:telephone) }
  it { should have_many(:reviews)              }
end
