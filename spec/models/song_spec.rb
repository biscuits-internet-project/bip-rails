require 'rails_helper'

RSpec.describe Song, type: :model do
  # Test validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      song = Song.new(title: 'A New Song', slug: 'a-new-song')
      expect(song).to be_valid
    end

    it 'is not valid without a title' do
      song = Song.new(slug: 'a-new-song')
      expect(song).not_to be_valid
    end

    it 'is not valid with a duplicate slug' do
      Song.create!(title: 'Existing Song', slug: 'existing-song')
      song = Song.new(title: 'New Song', slug: 'existing-song')
      expect(song).not_to be_valid
    end
  end

  # Test associations
  describe 'associations' do
    it { should belong_to(:author).optional }
    it { should have_many(:tracks).dependent(:destroy) }
    it { should have_many(:shows).through(:tracks) }
  end
end
