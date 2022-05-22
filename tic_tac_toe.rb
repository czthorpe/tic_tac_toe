class TicTacToe

    @@all_choices = []
    @@gameOver = false
    @@whose_turn = 1

    def self.playGame

        playerOne = PlayerOne.new 
        playerTwo = PlayerTwo.new

        while (@@gameOver == false)
            
            if @@whose_turn.odd?
                playerOne.getInput
                printBoard(playerOne, playerTwo)
                evaluateBoard(playerOne)
            else 
                playerTwo.getInput
                printBoard(playerOne, playerTwo)
                evaluateBoard(playerTwo)
            end

            @@whose_turn += 1
        end

    end

    def self.printBoard(playerOne, playerTwo)
        @@all_choices.sort!
        playerOne.player_choices.sort!
        playerTwo.player_choices.sort!

        (1..3).each do |i|
            puts '------------'
                str = '| '
                (1..3).each do |j|
                    if playerOne.player_choices.include?([i,j])
                        str += 'X | '
                    elsif playerTwo.player_choices.include?([i,j])
                        str += 'O | '
                    else 
                        str+= '  | '
                    end
                end
                puts str
                puts '------------'
        end
    end

    def self.evaluateBoard(player)
            choices = player.player_choices
            if choices.include?([2,2])
                if (choices.include?([1,1]) and choices.include?([3,3])) or (choices.include?([1,3]) and choices.include?([3,1]))
                    victoryScreen(player)
                end
            end

            (1..3).each do |row|
                h_match = 0
                v_match = 0
                (1..3).each do |column|
                    if choices.include?([row,column])
                        h_match += 1
                    end
                    if choices.include?([column,row])
                        v_match += 1
                    end 
                end
                if h_match == 3 or v_match == 3
                    victoryScreen(player)
                end
            end

    end

    def self.victoryScreen(player)
        puts "#{player.name} wins!"
        @@gameOver = true
    end

end

class Player < TicTacToe
    attr_accessor :name, :input, :player_choices

    def initialize
        self.name = gets.chomp
        @player_choices = []
    end

    def getInput()
        puts "#{@name}, input the coordinates of your choice (ex: '1,2')"
        @input = gets.chomp
        validateInput()
    end

    def validateInput()
        if @input.length == 3 and @input[0].to_i.between?(1,3) and @input[1] == ',' and @input[2].to_i.between?(1,3)
            @input = [@input[0].to_i, @input[2].to_i]

            if !@@all_choices.include?(@input)
                @@all_choices.push(@input)
                @player_choices.push(@input)
            else 
                handleError
            end

        else 
            handleError
        end
    end

    def handleError()
        puts 'Invalid input.'
        getInput
    end
end

class PlayerOne < Player

    def initialize
        puts "Player one, what is your name?"
        super
    end
end
class PlayerTwo < Player

    def initialize
        puts "Player two, what is your name?"
        super
    end
end

TicTacToe.playGame