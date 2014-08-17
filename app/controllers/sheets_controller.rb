class SheetsController < ApplicationController
  before_filter :find_topic, :only => [:new]

  def new
      @sheet = @topic.sheets.build
      #As sheets are outside of the Forem engine, the forum_id does not pass through as a resource.
      @sheet.forum_id = @topic.forum.id
  end

  def create

      @sheet = Sheet.new(sheet_params)
      #As sheets are outside of the Forem engine, the user does not pass through as a resource.
      @sheet.user = forem_user

      if @sheet.save
        create_successful
      else
        create_failed
      end
  end

  def edit
    #Allows for params embedded in the URL to be used to trace the sheet matching the oriignating topic and user.
    @sheet = Sheet.where(topic_id: params[:topic_id], user_id: forem_user.id).first
    #Likely overkill, may be worth removing during refactoring.
    @sheet.forum_id = params[:forum_id]
  end

  def update
      #Allows for params embedded in the URL to be used to trace the sheet matching the oriignating topic and user.
      @sheet = Sheet.where(topic_id: params[:sheet][:topic_id], user_id: forem_user.id).first
      @sheet.update_attributes(sheet_params)
      #As there is no association between the sheet and the topic or user, these values are passed on through the URL to allow for the user to re-enter the engine
      redirect_to forem.forum_topic_url(:action => "show", :contorller => "forem/topics", :format => nil, :forum_id => @sheet.forum_id, :id => @sheet.topic_id)
  end

  def destroy
  end

  def show
  end

      private

    def sheet_params
      params.require(:sheet).permit(:forum_id, :topic_id, :character_name, :str, :dex, :con, :wis, :int, :cha, :character_race, :character_class, :character_alignment, :armor_bonus, :shield_bonus, :fort_save, :ref_save, :will_save, :base_attack_bonus, :character_size, :nat_armor)
    end

    def find_topic
      @topic = Forem::Topic.find(params[:topic_id])
    end

    def create_successful
      flash[:notice] = "Your character sheet has been successfully saved."
      #As there is no association between the sheet and the topic or user, these values are passed on through the URL to allow for the user to re-enter the engine
      redirect_to forem.forum_topic_url(:action => "show", :contorller => "forem/topics", :format => nil, :forum_id => @sheet.forum_id, :id => @sheet.topic_id)
    end

    def create_failed
      params[:reply_to_id] = params[:post][:reply_to_id]
      flash.now.alert = "Your character sheet has not been successfully saved.  Please re-submit."
      render :action => "new"
    end

    def update_successful
      #As there is no association between the sheet and the topic or user, these values are passed on through the URL to allow for the user to re-enter the engine
      redirect_to forem.forum_topic_url(:action => "show", :contorller => "forem/topics", :format => nil, :forum_id => @sheet.forum_id, :id => @sheet.topic_id)
    end

    def update_failed
      flash.now.alert = t("forem.post.not_edited")
      render :action => "edit"
    end
end