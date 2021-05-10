class Post < ApplicationRecord

	validates :title, presence: true
  	validates :description, presence: true, length: { minimum: 10 }
  	require 'csv'

  	def self.to_csv
	    CSV.generate do |csv|
	      	csv << column_names
	      	all.each do |post|
	        	csv << post.attributes.values_at(*column_names)
	      	end
	    end
	end

	def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            post = Post.new
            post.title = row[0]
            post.description = row[1]
            post.status = row[2] == nil ? 1 : row[2]
            post.save
        end
    end

end
