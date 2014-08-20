Forem::TopicsController.class_eval do

	def show
		@sheets = topic.sheets
	end

end