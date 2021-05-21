class PostsRepository
	class << self
		def listAll(page,current_user)
            if(current_user.role == "0")
			    @posts = Post.where(deleted_at: nil).paginate(:page => page, :per_page => 10)
            else
                @posts = Post.where(create_user_id: current_user.id).where(deleted_at: nil).paginate(:page => page, :per_page => 10)
            end
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

        def destroyPost(post,current_user)
        	updatePost = post.update(
                'deleted_user_id' =>  current_user.id,
                'deleted_at'=> Time.now,
            )
        end

        def searchPostbysearchKey(searchKey,page,current_user)
		  	@parameter = searchKey.downcase
            if(current_user.role == "0")
                results = Post.joins(:created_user).where("name LIKE :search OR title LIKE :search OR description LIKE :search", search: "%#{@parameter}%").paginate(:page => page, :per_page => 10)
            else
                results = Post.joins(:created_user).where(create_user_id: current_user.id).where("name LIKE :search OR title LIKE :search OR description LIKE :search", search: "%#{@parameter}%").paginate(:page => page, :per_page => 10)
            end
		end
	end
end