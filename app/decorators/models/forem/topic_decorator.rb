Forem::Topic.class_eval do
	has_many :sheets
	#Decorator added for the sole purpose of changing the display order from ascending to decending.
	 has_many   :posts, -> { order "forem_posts.created_at DESC"}, :dependent => :destroy
end