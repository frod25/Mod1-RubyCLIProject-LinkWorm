class Link < ActiveRecord::Base

    has_many :users, through: :userlinks

end