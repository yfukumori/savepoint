Forem::PostsController.class_eval do
  #In order to add references to dice rolls, modifiers and roll results, the entire post controller was replicated and modified within this decorator.
  #Except where noted, all methods should be identical to those within the original engine.
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
      #Tabulates the randomized dice results from the player's turn and prevents a re-roll upon reloading or editing the post. 
      @post.result = roll_die
      if @post.save
        create_successful
      else
        create_failed
      end
    end

    def edit
    end

    def update
      if @post.owner_or_admin?(forem_user) && @post.update_attributes(post_params)
        update_successful
      else
        update_failed
      end
    end

    def destroy
      @post.destroy
      destroy_successful
    end

private
    def roll_die
      #reolling the dice
      total = 0
      @post.no_of_die.times do
        total += rand(@post.no_of_side)
      end
      #getting the correct sheet
      sheet = Sheet.where(:topic_id => @post.topic_id, :user_id => @post.user_id).first
      # adding the modifiers
      case :roll_mod
      when "str_mod"
        total += sheet.str_mod
      when "dex_mod"
        total += sheet.dex_mod
      when "con_mod"
        total += sheet.con_mod
      when "int_mod"
        total += sheet.int_mod
      when "wis_mod"
        total += sheet.wis_mod
      when "cha_mod"
        total += sheet.cha_mod
      when "attack"
        total += sheet.attack_mod
      when "fort_save"
        total += sheet.fort_save
      when "will_save"
        total += sheet.will_save
      when "ref_save"
        total += sheet.ref_save
      when "cmb"
        total += sheet.cmb
      end
      
      return total
    end

    def post_params
      #no_of_die, no_of_side and roll_mod not original to Forem engine
      params.require(:post).permit(:text, :reply_to_id, :no_of_die, :no_of_side, :roll_mod)
    end

    def authorize_reply_for_topic!
      authorize! :reply, @topic
    end

    def authorize_edit_post_for_forum!
      authorize! :edit_post, @topic.forum
    end

    def authorize_destroy_post_for_forum!
      authorize! :destroy_post, @topic.forum
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

        def destroy_successful
      if @post.topic.posts.count == 0
        @post.topic.destroy
        flash[:notice] = t("forem.post.deleted_with_topic")
        redirect_to [@topic.forum]
      else
        flash[:notice] = t("forem.post.deleted")
        redirect_to [@topic.forum, @topic]
      end
    end

    def update_successful
      redirect_to [@topic.forum, @topic], :notice => t('edited', :scope => 'forem.post')
    end

    def update_failed
      flash.now.alert = t("forem.post.not_edited")
      render :action => "edit"
    end

    def ensure_post_ownership!
      unless @post.owner_or_admin? forem_user
        flash[:alert] = t("forem.post.cannot_delete")
        redirect_to [@topic.forum, @topic] and return
      end
    end

    def find_topic
      @topic = Forem::Topic.friendly.find params[:topic_id]
    end

    def find_post_for_topic
      @post = @topic.posts.find params[:id]
    end

    def block_spammers
      if forem_user.forem_spammer?
        flash[:alert] = t('forem.general.flagged_for_spam') + ' ' +
                        t('forem.general.cannot_create_post')
        redirect_to :back
      end
    end

    def reject_locked_topic!
      if @topic.locked?
        flash.alert = t("forem.post.not_created_topic_locked")
        redirect_to [@topic.forum, @topic] and return
      end
    end
end