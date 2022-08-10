class Game

    COLORS = ["r", "g", "b", "y", "p", "o"]

    def generate_code
        code = []
        4.times do
            code.push(COLORS[rand(6)])
        end
        p code
    end

end

class Player

    def guess()
        puts "r = red, g = green, b = blue, y = yellow, p = purple, o = orange. Select a combination of 4"
        player_guess = gets.chomp.downcase.split('')
        unless (player_guess - Game::COLORS).empty? && player_guess.length == 4
            guess()
        end
        p player_guess
    end

end


game = Game.new
game.generate_code
player = Player.new
player.guess()