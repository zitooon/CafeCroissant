class Admin < ActiveRecord::Base
	validates_presence_of :name, :password
end
