require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { create(:category) }

  it 'is a valid category' do
    expect(category).to be_valid
  end
end
