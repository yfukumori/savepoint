class SheetsController < ApplicationController
  before_filter :find_topic, :only => [:new]

  def new
      @sheet = @topic.sheets.build
  end

  def create
      @sheet = @topic.sheets.build(sheet_params)
      @sheet.user = forem_user

      if @sheet.save
        create_successful
      else
        create_failed
      end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def show
  end

      private

    def sheet_params
      params.require(:sheet).permit(:character_name, :str, :dex, :con, :wis, :int, :cha, :character_race, :character_class, :character_alignment, :armor_bonus, :shield_bonus, :fort_save, :ref_save, :will_save, :base_attack_bonus, :character_size, :nat_armor)
    end

    def find_topic
      # @topic = Topic.friendly.find params[:topic_id]
      @topic = Forem::Topic.find(params[:topic_id])
    end
end