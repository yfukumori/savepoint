class PagesController < ApplicationController
	def home
		@p = Forem::Post.new
	end
end
