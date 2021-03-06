class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :store_user_location!, if: :storable_location?


  def show
    @booking = Booking.new()
  end

  def new
    @professional = Professional.new
    authorize @professional
    @user = User.new
  end

  def create
    @professional = Professional.new(professional_params)
    authorize @professional
    @professional.user = current_user
    if @professional.save
      redirect_to professional_path(@professional)
    else
      render :new
    end
  end

  def update

    # if @user.update(user_params)
    #   redirect_to @user, notice: 'Your user was successfully updated.'
    # else
    #   render :edit
    # end
    if @professional.update(professional_params)
      redirect_to @professional, notice: 'Your professional was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @professional.destroy
    redirect_to admin_professionals_path, notice: 'Professional was successfully destroyed.'
  end

  private

  def set_professional
    @professional = Professional.find(params[:id])
    authorize @professional
  end


  def professional_params
    params.require(:professional).permit(:location, :resume, :experience_in_years, :company_logo, :career_id, :specialty)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
