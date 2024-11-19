require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  let(:user) { create(:user) }
  let(:venue) { create(:venue, user: user) }
  let(:category) { create(:category) }


  describe 'GET #index' do
    it 'assigns all active venues to @venues' do
      active_venue = create(:venue, is_active: true)
      inactive_venue = create(:venue, is_active: false)

      get :index

      expect(assigns(:venues)).to include(active_venue)
      expect(assigns(:venues)).not_to include(inactive_venue)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested venue to @venue and related models' do
      question = create(:question, venue: venue)
      answer = create(:answer, question: question)

      get :show, params: { id: venue.id }

      expect(assigns(:venue)).to eq(venue)
      expect(assigns(:questions)).to include(question)
      expect(assigns(:question)).to be_a_new(Question)
      expect(assigns(:answer)).to be_a_new(Answer)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Venue to @venue' do
      sign_in(user)
      get :new
      expect(assigns(:venue)).to be_a_new(Venue)
      expect(assigns(:categories)).to eq(Category.all)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new venue and redirects' do
        sign_in(user)
        venue_params = attributes_for(:venue, user_id: user.id)

        expect {
          post :create, params: { venue: venue_params }
        }.to change(Venue, :count).by(1)

        expect(response).to redirect_to(venues_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new venue and re-renders the new template' do
        sign_in(user)
        invalid_params = attributes_for(:venue, name: nil)

        expect {
          post :create, params: { venue: invalid_params }
        }.not_to change(Venue, :count)

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(new_venue_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the venue and redirects to edit page' do
        sign_in(user)
        patch :update, params: { id: venue.id, venue: { name: 'Updated Name' } }

        venue.reload
        expect(venue.name).to eq('Updated Name')
        expect(flash[:notice]).to eq('Lokal został pomyślnie zaktualizowany')
        expect(response).to redirect_to(edit_venue_path(venue))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the venue and re-renders the edit page' do
        sign_in(user)
        patch :update, params: { id: venue.id, venue: { name: nil } }

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(edit_venue_path(venue))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the venue and redirects to profile' do
      venue
      sign_in(user)

      expect {
        delete :destroy, params: { id: venue.id }
      }.to change(Venue, :count).by(-1)

      expect(flash[:notice]).to eq('Lokal został pomyślnie usunięty')
      expect(response).to redirect_to(:profile)
    end
  end

  describe 'DELETE #remove_photo' do
    it 'removes the primary photo from the venue' do
      sign_in(user)
      expect(venue.primary_photo).to be_attached

      delete :remove_photo, params: { id: venue.id, photo_id: venue.primary_photo.blob.id }

      venue.reload

      expect(venue.primary_photo).not_to be_attached
      expect(response).to redirect_to(edit_venue_path(venue))
    end
  end
end
