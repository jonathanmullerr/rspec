require 'rails_helper'

RSpec.describe "/customers", type: :request do
  let(:valid_attributes) { { name: "John Doe" } }
  let(:invalid_attributes) { { name: nil } }
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }

  describe 'Authentication' do 
    context 'Unauthenticated' do
      it 'allows access to index' do
        get customers_url
        expect(response).to be_successful
      end 

      it 'redirects to login for new customer' do 
        get new_customer_url
        expect(response).to redirect_to(new_user_session_path)
      end
  
      it 'renders not authorized http status for customer' do     
        get customer_url(customer)
        expect(response).to have_http_status(302)
      end
    end

    context 'Authenticated' do
      before { sign_in user }

      it 'successfully accesses new customer' do
        get new_customer_url
        expect(response).to be_successful
      end
    end
  end

  describe "Actions" do 
    before { sign_in user }

    context "GET /index" do
      it "renders a successful response" do
        get customers_url
        expect(response).to be_successful
      end
    end

    context "GET /show" do
      it "renders a successful response" do
        get customer_url(customer)
        expect(response).to be_successful
      end

      it 'content-type html' do
        get customer_url(customer)
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end

      it 'content-type json' do
        get customer_url(customer, format: :json)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "GET /new" do
      it "renders a successful response" do
        get new_customer_url
        expect(response).to be_successful
      end
    end

    context "GET /edit" do
      it "renders a successful response" do
        get edit_customer_url(customer)
        expect(response).to be_successful
      end
    end

    context "POST /create" do
      context "with valid parameters" do
        it "creates a new Customer" do
          expect {
            post customers_url, params: { customer: valid_attributes }
          }.to change(Customer, :count).by(1)
        end

        it 'flash notice' do
          post customers_url, params: { customer: valid_attributes }
          expect(flash[:notice]).to match(/successfully created/)
        end

        it "redirects to the created customer" do
          post customers_url, params: { customer: valid_attributes }
          expect(response).to redirect_to(customer_url(Customer.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Customer" do
          expect {
            post customers_url, params: { customer: invalid_attributes }
          }.to change(Customer, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post customers_url, params: { customer: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "PATCH /update" do
      let(:new_attributes) { { name: "Jane Doe" } }

      context "with valid parameters" do
        it "updates the requested customer" do
          patch customer_url(customer), params: { customer: new_attributes }
          customer.reload
          expect(customer.name).to eq("Jane Doe")
        end

        it "redirects to the customer" do
          patch customer_url(customer), params: { customer: new_attributes }
          customer.reload
          expect(response).to redirect_to(customer_url(customer))
        end
      end

      context "with invalid parameters" do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch customer_url(customer), params: { customer: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "DELETE /destroy" do
      it "destroys the requested customer" do
        customer = create(:customer)
        expect {
          delete customer_url(customer)
        }.to change(Customer, :count).by(-1)
      end

      it "redirects to the customers list" do
        customer = create(:customer)
        delete customer_url(customer)
        expect(response).to redirect_to(customers_url)
      end
    end
  end
end
