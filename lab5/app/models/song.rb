class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validate :must_have_at_least_one_artist

    has_and_belongs_to_many :artists
    has_and_belongs_to_many :genres

    private

    def must_have_at_least_one_artist
        if artist_ids.blank?
            errors.add(:artists, "must have at least one artist")
        end
    end
end
