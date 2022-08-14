class Game

    attr_accessor :code, :player

    COLORS = %w(r g b y p o)

    def initialize
        @code = generate_code()
        @player = Player.new
        @tracker = []
        @guess = 1
    end

    def generate_code
        code = []
        4.times do
            code.push(COLORS[rand(6)])
        end
        code
    end

    def start_game_player_guess(player)
        check_player_guess(self.code, player.guess)
        next_turn(player, self.code)
    end

    def next_turn(player, secret_code)
        player_guess = player.guess
        key = check_player_guess(secret_code, player_guess)
        unless key == ["Green", "Green", "Green", "Green"]
            next_turn(player, secret_code)
        else puts "WINNER YOU GUESSED THE CODE"
        end
    end

    def choose_role(player)
        puts "To create the code, input 'c', to guess the code, input 'g'"
        input = gets.chomp.downcase
        case input
        when 'c'
            player_code = player.get_code
            start_game_computer_guess(computer_guess(), player_code)
        when 'g'
            start_game_player_guess(player)
        else choose_role(player)
        end
    end

    def check_player_guess(secret_code, player_guess)
        code_key = []
        temp_player_guess = player_guess.clone
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
        message = "Guess #{@guess}: #{temp_player_guess} and code key is #{code_key}"
        @tracker.push(message)
        puts @tracker
        @guess += 1
        code_key
    end

    def computer_guess
        code = []
        4.times do
            code.push(COLORS[rand(6)])
        end
        code
    end

    def start_game_computer_guess(computer_guess, player_code)
        12.times do
            puts "Computer guessed #{computer_guess} and the code is #{player_code}"
            if computer_guess == player_code then puts "Computer guessed correctly! Computer Wins!"
            end
        end
        puts "Computer didn't guess correctly. Computer loses!"
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

    def get_code 
        puts "r = red, g = green, b = blue, y = yellow, p = purple, o = orange. Input a combination of 4"
        player_code = gets.chomp.downcase.split('')
        unless (player_code - Game::COLORS).empty? && player_code.length == 4
            get_code()
        end
        player_code
    end

end


game = Game.new
game.choose_role(game.player)