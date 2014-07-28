class SheetsController < ApplicationController

  def index
    @sheets = Sheet.all
  end

  def show
    @sheets = Sheet.find(params[:id])
  end

  def new
    @sheet = Sheet.new
  end

  def edit
    @sheet = Sheet.find(params[:id])
  end

  def update
    @sheet = Sheet.find(params[:id])

    if @sheet.update_attributes(sheet_params)
      redirect_to "/sheets/#{@sheet.id}"
    else
      render :edit
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy
    redirect_to sheets_url
  end

  def create
    @sheet = Sheet.new(sheet_params)
    if @sheet.save
      redirect_to sheets_url
    else
      render :new
    end
  end

  private
  def sheet_params
    params.require(:sheet).permit(:character_name, :character_race, :character_class, :character_alignment, :str, :dex, :con, :wis, :int, :cha, :armor_bonus, :shield_bonus, :fort_save, :ref_save, :will_save, :base_attack_bonus, :character_size, :nat_armor)
  end
end