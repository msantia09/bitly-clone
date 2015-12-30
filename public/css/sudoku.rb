class Sudoku
  def initialize(board_string)
  	@board_arr = []
  	@result_board_arr = []
  	string_arr = board_string.split(//)
  	string_arr.each_slice(9) {|row| @board_arr << row}
  end

  def solve!
  	until finished?
  	@board_arr.each_with_index do |row, row_index|
  		row.each_with_index do |item, item_index|
  			
  			if item == "0"
  				#p "Item_index = #{item_index}"
  				#p "Row_index = #{row_index}"

  				item_arr = (1..9).to_a.map(&:to_s)

  				for i in 0..8
  					if row[i] != 0
  						item_arr.delete row[i] if item_arr.include? row[i]
  					end
  				end
  				#p "After eliminating row: #{item_arr}"

  				for i in 0..8	
  					if @board_arr[i][item_index] != 0
  						item_arr.delete @board_arr[i][item_index] if item_arr.include? @board_arr[i][item_index]
  					end
   				end
   				#p "After eliminating col: #{item_arr}"

   				if row_index < 3
   					boxrow_start = 0
   					boxrow_end = 2
   				elsif row_index < 6
   					boxrow_start = 3
   					boxrow_end = 5
   				elsif row_index < 9
   					boxrow_start = 6
   					boxrow_end = 8
   				end

   				if item_index < 3
   					boxcol_start = 0
   					boxcol_end = 2
   				elsif item_index < 6
   					boxcol_start = 3
   					boxcol_end = 5
   				elsif item_index < 9
   					boxcol_start = 6
   					boxcol_end = 8
   				end
   					
   				for i in (boxrow_start..boxrow_end)
   					for j in (boxcol_start..boxcol_end)
   						if @board_arr[i][j] != 0
   							item_arr.delete @board_arr[i][j] if item_arr.include? @board_arr[i][j]
  						end
  					end
  				end
  				#p "After eliminating box: #{item_arr}"
  				#p "Item = #{item}"

  				if item_arr.length == 1
  					@board_arr[row_index][item_index] = item_arr[0]
  				end
  			end
  		end
  	end
  	end
  	#p @board_arr
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board  	
  	@board_arr.each do |x|
  		p x
  	end
  end

  def finished?
  	if @board_arr.flatten.count("0") == 0
  		return true
  	else
  		return false
  	end
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)

puts "UNSOLVED.."
game.board
# Remember: this will just fill out what it can and not "guess"
game.solve!
puts "SOLVED..!!"
game.board