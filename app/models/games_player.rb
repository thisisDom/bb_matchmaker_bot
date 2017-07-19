class GamesPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :team, :pregame_elo, :expected_win_change, :expected_loss_change, { numericality: { only_integer: true,
                                                                                                greater_than_or_equal_to: 0
                                                                                              }
                                                                              }
  validates :player, uniqueness: { scope: :game }

end
