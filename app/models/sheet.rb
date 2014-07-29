class Sheet < ActiveRecord::Base
    belongs_to :forem_user, :class_name => Forem.user_class.to_s, :foreign_key => :user_id
	belongs_to :topic
end
