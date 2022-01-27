require 'rails_helper'

describe 'Projects exportation API' do
  context 'GET /api/v1/projects' do
    it 'should get only open projects' do
      user = RegularUser.create!(email: 'gabriel@user.com', password: '123456')
      @project1 = Project.create!(title: 'Aluguel de imóveis',
                                  description: 'Site para alugar imóveis',
                                  skills: 'Conhecimento em Rails',
                                  value: 50,
                                  end_date: '10/11/2021',
                                  work_style: 'Remota',
                                  regular_user: user, 
                                  status: 5)
      @project2 = Project.create!(title: 'Netflix',
                                  description: 'Uma aplicação para streaming de vídeos',
                                  skills: 'Conhecimento em Rails',
                                  value: 50,
                                  end_date: '10/11/2021',
                                  work_style: 'Remota',
                                  regular_user: user, 
                                  status: 5)
      @project3 = Project.create!(title: 'Bar.com',
                                  description: 'Uma aplicação para streaming de vídeos',
                                  skills: 'Conhecimento em Rails',
                                  value: 50,
                                  end_date: '10/11/2021',
                                  work_style: 'Remota',
                                  regular_user: user, 
                                  status: 10)

      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      projects = parsed_body
      expect(projects.first[:project][:title]).to include('Aluguel de imóveis')
      expect(projects.second[:project][:title]).to include('Netflix')
      expect(projects.size).to eq(2)
    end
  end
end 