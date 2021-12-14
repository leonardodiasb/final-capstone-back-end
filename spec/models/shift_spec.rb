require 'rails_helper'

RSpec.describe Shift, type: :model do
  let!(:shift) { create(:shift) }

  it 'is a valid shift' do
    expect(shift).to be_valid
  end
end
