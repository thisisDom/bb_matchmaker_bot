class Player < ApplicationRecord
  has_one :queued_player

  validates :username, :discord_id, { presence: true,
                                      uniqueness: { case_sensetive: false }
                                    }
  validates :discord_id, :elo, { numericality: { only_integer: true,
                                                greater_than_or_equal_to: 0
                                              }
                              }
end
