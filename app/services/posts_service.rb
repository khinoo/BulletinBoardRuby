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

		def createPost(post)
			savePost = PostsRepository.createPost(post)
		end

		def updatePost(post_form)
			post = findPostById(post_form[:id])
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