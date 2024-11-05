class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_venue, except: [ :index, :new, :create ]
  before_action :check_if_user_owns_venue, only: [ :edit, :update, :destroy ]
  before_action :set_categories, only: [ :new, :edit ]

  def index
    @venues = Venue.active.all
  end

  def show
    @questions = @venue.questions
    @question = Question.new
    @answer = Answer.new
  end

  def new
    @venue = Venue.new()
  end

  def create
    @venue = Venue.new(venue_params.merge(user_id: current_user.id))
    if @venue.save
      redirect_to venues_path
    else
      flash[:alert] = @venue.errors[:photos].any? ? @venue.errors[:photos].join(", ") : "There was an error creating the venue."
      redirect_to new_venue_path
    end
  end

  def edit
    @venue.categories
  end

  def update
    if @venue.update(venue_params)
      redirect_to edit_venue_path(@venue)
      flash[:notice] = "Lokal został pomyślnie zaktualizowany"
    else
      flash[:alert] = @venue.errors[:photos].any? ? @venue.errors[:photos].join(", ") : "There was an error updating the venue."
      redirect_to edit_venue_path(@venue)
    end
  end

  def destroy
    @venue.destroy
    flash[:notice] = "Lokal został pomyślnie usunięty"
    redirect_to :profile
  end

  def remove_photo
    photo = ActiveStorage::Attachment.find(params[:photo_id])
    photo.purge_later
    redirect_to(edit_venue_path(@venue))
  end

  private
  def set_venue
    @venue = Venue.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def venue_params
    params.require(:venue).permit(:name, :is_active, :user_id, :primary_photo, photos: [], category_ids: [])
  end

  def check_if_user_owns_venue
    owner = current_user
    venue = Venue.find(params[:id])
    if owner != venue.user
      flash[:alert] = "Mozesz edytować tylko swoje lokale"
      redirect_to root_path
    end
  end
end
