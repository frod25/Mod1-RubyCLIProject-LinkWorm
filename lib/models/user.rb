class User < ActiveRecord::Base

    has_many :links, through: :userlinks

end