class PostsService
	class << self
		def listAll(page)
			@posts = PostsRepository.listAll(page)
		end

		def findPostById(id)
			@post = PostsRepository.findPostById(id)
		end

		def newPost
			@post = PostsRepository.newPost
		end

		def createPost(post,current_user)
			savePost = PostsRepository.createPost(post,current_user)
		end

		def updatePost(post_form,current_user)
			post = findPostById(post_form[:id])
			post.updated_user_id = current_user.id
			post.updated_at = Time.now
			updatePost = PostsRepository.updatePost(post,post_form)
		end

		def destroyPost(id)
			@destroyPost = PostsRepository.findPostById(id)
			destroyPost = PostsRepository.destroyPost(@destroyPost)
		end

		def searchPost(searchKey)
	      posts = PostsRepository.searchPostbysearchKey(searchKey)
	    end
	end
end