Forem::PostsController.class_eval do
    def new
      @post = @topic.posts.build
      find_reply_to_post

      if params[:quote] && @reply_to_post
        @post.text = view_context.forem_quote(@reply_to_post.text)
      elsif params[:quote] && !@reply_to_post
        flash[:notice] = t("forem.post.cannot_quote_deleted_post")
        redirect_to [@topic.forum, @topic]
      end
    end

    def create
      @post = @topic.posts.build(post_params)
      @post.user = forem_user

      if @post.save
        create_successful
      else
        create_failed
      end
    end

private

        def post_params
      params.require(:post).permit(:text, :reply_to_id)
    end

    def find_reply_to_post
      @reply_to_post = @topic.posts.find_by_id(params[:reply_to_id])
    end

        def create_successful
      flash[:notice] = t("forem.post.created")
      redirect_to forum_topic_url(@topic.forum, @topic, pagination_param => @topic.last_page)
    end

    def create_failed
      params[:reply_to_id] = params[:post][:reply_to_id]
      flash.now.alert = t("forem.post.not_created")
      render :action => "new"
    end
end