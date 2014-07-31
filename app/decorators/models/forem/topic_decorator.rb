Forem::Topic.class_eval do
	has_many :sheets
	 has_many   :posts, -> { order "forem_posts.created_at DESC"}, :dependent => :destroy
end