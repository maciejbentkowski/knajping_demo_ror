# spec/controllers/reviews_controller_spec.rb
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:venue_owner) { create(:user) }
  let(:venue) { create(:venue, user: venue_owner) }

  describe 'GET #show' do
    let(:review) { create(:review, venue: venue) }

    it 'renders the show template' do
      get :show, params: { venue_id: venue.id, id: review.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested review' do
      get :show, params: { venue_id: venue.id, id: review.id }
      expect(assigns(:review)).to eq(review)
    end

    it 'initializes a new comment' do
      get :show, params: { venue_id: venue.id, id: review.id }
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'GET #new' do
    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get :new, params: { venue_id: venue.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'when user has not reviewed the venue yet' do
        it 'renders the new template' do
          get :new, params: { venue_id: venue.id }
          expect(response).to render_template(:new)
        end

        it 'builds a new review with rating' do
          get :new, params: { venue_id: venue.id }
          expect(assigns(:review)).to be_a_new(Review)
          expect(assigns(:review).rating).to be_a_new(Rating)
        end
      end

      context 'when user has already reviewed the venue' do
        let!(:existing_review) { create(:review, user: user, venue: venue) }

        it 'redirects to edit template' do
          get :new, params: { venue_id: venue.id }
          expect(response).to redirect_to(edit_venue_review_path(venue, existing_review))
        end
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        title: 'Great Place',
        content: 'Amazing experience',
        rating_attributes: {
          atmosphere_rating: 5,
          availability_rating: 5,
          quality_rating: 5,
          service_rating: 5,
          uniqueness_rating: 5,
          value_rating: 5
        }
      }
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        post :create, params: { venue_id: venue.id, review: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'creates a new review' do
          expect {
            post :create, params: { venue_id: venue.id, review: valid_attributes }
          }.to change(Review, :count).by(1)
        end

        it 'redirects to venue page' do
          post :create, params: { venue_id: venue.id, review: valid_attributes }
          expect(response).to redirect_to(venue_path(venue))
        end

        it 'sets the correct avg_rating' do
          post :create, params: { venue_id: venue.id, review: valid_attributes }
          expect(Review.last.avg_rating).to eq(5.0)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { { title: '', content: '' } }

        it 'does not create a new review' do
          expect {
            post :create, params: { venue_id: venue.id, review: invalid_attributes }
          }.not_to change(Review, :count)
        end

        it 're-renders the new template' do
          post :create, params: { venue_id: venue.id, review: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #edit' do
    let!(:review) { create(:review, user: user, venue: venue) }

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get :edit, params: { venue_id: venue.id, id: review.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      it 'renders the edit template' do
        get :edit, params: { venue_id: venue.id, id: review.id }
        expect(response).to render_template(:edit)
      end

      it 'assigns the requested review' do
        get :edit, params: { venue_id: venue.id, id: review.id }
        expect(assigns(:review)).to eq(review)
      end

      context 'when review belongs to another user' do
        let(:other_user) { create(:user) }
        let!(:other_review) { create(:review, user: other_user, venue: venue) }

        it 'redirects to review venue path' do
          get :edit, params: { venue_id: venue.id, id: other_review.id }
          expect(response).to redirect_to(venue_path(venue))
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:review) { create(:review, user: user, venue: venue) }
    let(:update_attributes) do
      {
        title: 'Updated Title',
        content: 'Updated Content',
        rating_attributes: {
          atmosphere_rating: 4,
          availability_rating: 4,
          quality_rating: 4,
          service_rating: 4,
          uniqueness_rating: 4,
          value_rating: 4
        }
      }
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        patch :update, params: { venue_id: venue.id, id: review.id, review: update_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'updates the review' do
          patch :update, params: { venue_id: venue.id, id: review.id, review: update_attributes }
          review.reload
          expect(review.title).to eq('Updated Title')
        end

        it 'redirects to venue page' do
          patch :update, params: { venue_id: venue.id, id: review.id, review: update_attributes }
          expect(response).to redirect_to(venue_path(venue))
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { { title: '', content: '' } }

        it 'does not update the review' do
          original_title = review.title
          patch :update, params: { venue_id: venue.id, id: review.id, review: invalid_attributes }
          review.reload
          expect(review.title).to eq(original_title)
        end

        it 're-renders the edit template' do
          patch :update, params: { venue_id: venue.id, id: review.id, review: invalid_attributes }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
