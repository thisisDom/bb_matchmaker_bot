class Player < ApplicationRecord
  has_one :queue, { class_name: 'QueuedPlayer' }, dependant: :destroy

  has_many :games_created, { class_name: 'Game', foreign_key: :creator_id }

  validates :username, :discord_id, { presence: true,
                                      uniqueness: { case_sensetive: false }
                                    }
  validates :discord_id, :elo, { numericality: { only_integer: true,
                                                greater_than_or_equal_to: 0
                                              }
                              }
end
