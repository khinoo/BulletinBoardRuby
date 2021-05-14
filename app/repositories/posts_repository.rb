class PostsRepository
	class << self
		def listAll(page)
			@posts = Post.where(deleted_at: nil).paginate(:page => page, :per_page => 10)
		end

		def findPostById(id)
            @post = Post.find(id)
        end

        def newPost
        	@post = Post.new
        end

        def createPost(post,current_user)
        	@post = Post.new(post)
        	@post.status = 1 # default 1 when post create
            @post.create_user_id = current_user.id
            @post.updated_user_id = current_user.id
            @post.updated_at = Time.now
        	savePost = @post.save
        end

        def updatePost(post,post_form)
        	updatePost = post.update(post_form)
        end

        def destroyPost(post)
        	post.update_attribute(:deleted_at, Time.now)
        end

        def searchPostbysearchKey(searchKey)
		  	@parameter = searchKey.downcase  
    		results = Post.where("title LIKE :search OR description LIKE :search", search: "%#{@parameter}%")
		end
	end
end