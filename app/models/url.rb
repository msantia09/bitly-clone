class Url < ActiveRecord::Base

	before_create :shorten
	
	def shorten
		new_str = []
		new_str << (0..9).to_a
		new_str << ('A'..'Z').to_a
		new_str << ('a'..'z').to_a
		new_str.flatten!
		self.short_url = (0..6).map{new_str[rand(62)]}.join
	end

end
