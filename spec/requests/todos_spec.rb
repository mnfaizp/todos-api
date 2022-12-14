require 'rails_helper'

RSpec.describe "Todos API", type: :request do
    # initialize
    let(:user) { create(:user) }
    let!(:todos) { create_list(:todo, 10, created_by: user.id) }
    let(:todo_id) { todos.first.id }
    let(:headers) { valid_headers }


    # Test for GET /todos
    describe "GET /todos" do
        # make http request
        before { get "/todos", params: {}, headers: headers }

        it "returns todos" do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end

    # Test for GET /todos/id
    describe "GET /todos/:id" do
        before { get "/todos/#{todo_id}", params: {}, headers: headers }

        context "when the record exists" do
            it "returns the todo" do
                expect(json).not_to be_empty
                expect(json['id']).to eq(todo_id)
            end
            
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end
        end
        
        context "when the record doesnt exists" do
            let(:todo_id) { 100 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end

            it "returns not found message" do
                expect(response.body).to match(/Couldn't find Todo/)
            end
        end
    end

    # Test POST /todos
    describe 'POST /todos' do
        #valid paylod
        let(:valid_attributes) { { title: 'Learn Elm', created_by: user.id.to_s }.to_json }

        context "when the request is valid" do
            before { post '/todos', params: valid_attributes, headers: headers }

            it 'creates a todo' do
                expect(json['title']).to eq('Learn Elm')
            end

            it 'return status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context "when the request is invalid" do
            before { post '/todos', params: { title: nil }.to_json, headers: headers }

            it "returns status code 422" do
                expect(response).to have_http_status(422) 
            end

            it "returns a validation failure message" do
                expect(json['message'])
                    .to match(/Validation failed: Title can't be blank/)
            end
        end
    end

    # Test for PUT /todos/:id
    describe "PUT /todos/:id" do
        let(:valid_attributes) { { title: 'Shopping' }.to_json }

        context "when the record exists" do
            before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

            it "updatees the record" do
                expect(response.body).to be_empty     
            end

            it "return status code 204" do
                expect(response).to  have_http_status(204)
            end
            
        end
    end
    
    #Test for DELETE /todos/:id
    describe "DELETE /todos/:id" do
        before { delete "/todos/#{todo_id}", params: {}, headers: headers }

        it "return status code 204" do
            expect(response).to have_http_status(204) 
        end
        
    end
end