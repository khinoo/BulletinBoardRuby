module PostsHelper
  def self.check_csvdata(file)
  	error = "" 
    CSV.foreach(file.path, headers: true) do |row|
    	post = Post.where(title: row[0])
    	if post.present?
	    	error = "Post already exists!!!!."
	    end
    end
	return error
  end
end