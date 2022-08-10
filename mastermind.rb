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
        (0..3).each do |i|
            if player_guess[i] == temp_secret_code[i]
                code_key.push("Green")
                temp_secret_code[i] = nil
                player_guess[i] = nil
            end
        end
        player_guess.compact!
        temp_secret_code.compact!
        player_guess.each do |player_color_guess|
            if temp_secret_code.include? player_color_guess
                code_key.push("Yellow")
                temp_secret_code[temp_secret_code.index(player_color_guess)] = "GUESSED"
            else code_key.push("Gray")
            end
        end
        puts "code key is #{code_key} and code is #{secret_code}"
        code_key
    end

    def next_turn(player, secret_code)
        player_guess = player.guess
        key = check_player_guess(secret_code, player_guess)
        unless key == ["Green", "Green", "Green", "Green"]
            next_turn(player, secret_code)
        else puts "WINNER YOU GUESSED THE CODE"
        end
    end

    def start_game(player)
        check_player_guess(self.code, player.guess)
    end

end

class Player

    def guess
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
game.start_game(player)