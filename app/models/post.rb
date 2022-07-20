class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validate :click_bait

    CLICKBAIT_PATTERNS = [
        "Won't Believe",
        "Secret",
        "Top[number]",
        "Guess"
    ]

    def click_bait
        unless title.blank? || CLICKBAIT_PATTERNS.any? {|p| title.match(p)}
            errors.add(:title, "title not clickbait-y enough")
        end
    end
end
