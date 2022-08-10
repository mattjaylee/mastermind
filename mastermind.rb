class Game

    attr_accessor :code

    COLORS = %w(r g b y p o)

    def initialize
        @code = generate_code()
    end

    def generate_code
        code = []
        4.times do
            code.push(COLORS[rand(6)])
        end
        code
    end

    def check_player_guess(secret_code, player_guess)
        code_key = []
        temp_secret_code = secret_code.clone
        player_guess.each_with_index do |player_color_guess, index|
            if player_color_guess == temp_secret_code[index]
                code_key.push("Green")
                temp_secret_code[index] = "GUESSED"
            elsif temp_secret_code.include? player_color_guess
                code_key.push("Yellow")
                temp_secret_code[temp_secret_code.index(player_color_guess)] = "GUESSED"
            else code_key.push("Gray")
            end
        end
        puts "code key is #{code_key} and code is #{secret_code}"
    end

end

class Player

    def guess()
        puts "r = red, g = green, b = blue, y = yellow, p = purple, o = orange. Input a combination of 4"
        player_guess = gets.chomp.downcase.split('')
        unless (player_guess - Game::COLORS).empty? && player_guess.length == 4
            guess()
        end
        player_guess
    end

end


game = Game.new
player = Player.new
guess = player.guess
#game.check_player_guess(["p", "b", "r", "r"], ["r", "r", "g", "g"])
game.check_player_guess(game.code, guess)