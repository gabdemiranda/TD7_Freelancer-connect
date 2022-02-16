require 'rails_helper'

describe 'API Users' do
  context 'POST /api/v1/login' do
    it 'should login successfully and receive a token' do
      client = ApiUser.create!(username: 'user', password: '123321')

      post '/api/v1/login',
        params: {
          username: client.username,
          password: client.password
        }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      client_info = parsed_body
      expect(client_info[:api_user][:api_user][:username]).to include('user')
      expect(client_info[:api_user][:api_user][:token]).not_to eq('nil')
    end

    it 'should not login successfully because account not created' do

      post '/api/v1/login',
        params: {
          username: "user",
          password: "123456"
        }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      client_info = parsed_body
      expect(client_info[:error]).to include('Invalid username or password')
    end

    it 'should not login successfully because of wrong password' do
      client = ApiUser.create!(username: 'user', password: '123321')

      post '/api/v1/login',
        params: {
          username: "user",
          password: "123456"
        }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      client_info = parsed_body
      expect(client_info[:error]).to include('Invalid username or password')
    end

    it 'should not login successfully because of wrong username' do
      client = ApiUser.create!(username: 'user', password: '123456')

      post '/api/v1/login',
        params: {
          username: "userwrong",
          password: client.password
        }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      client_info = parsed_body
      expect(client_info[:error]).to include('Invalid username or password')
    end
  end
  context "POST /api/v1/api_users" do
    it 'should create an api client successfully' do

      post '/api/v1/api_users',
      params: {
        username: 'user',
        password: '123456789'
      }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      client_info = parsed_body
      expect(client_info[:api_user][:api_user][:username]).to include('user')
      expect(client_info[:api_user][:api_user][:token]).not_to eq('nil')
    end
  end
end 