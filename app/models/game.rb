class Game < ApplicationRecord
  belongs_to :creator, { class_name: 'Player' }


  validates :winning_team, { numericality: { only_integer: true,
                                             greater_than_or_equal_to: 0
                                           }
                           }
  validates :game_map, :game_mode, { presence: true }
end
