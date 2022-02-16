# frozen_string_literal: true

require 'rails_helper'

describe 'Regular user can open project' do
  it 'and can finish the project' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    Project.create!({ title: 'Site para cadastro de imóveis',
                      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                      skills: 'Ruby on Rails',
                      value: 50,
                      end_date: '10/11/2021',
                      work_style: 'Remota',
                      regular_user: regularuser })

    login_as regularuser, scope: :regular_user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Site para cadastro de imóveis'
    click_on 'Finalizar projeto'

    expect(page).to have_content('Projeto finalizado!')
    expect(page).to have_content('Site para cadastro de imóveis')
    expect(page).to have_content('Preciso de um site que cadastre imóveis de vários tipos e em várias locações')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Remota')
  end

  it 'and can send a feedback after finishing project' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    project = Project.create!({ title: 'Site para cadastro de imóveis',
                                description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                                skills: 'Ruby on Rails',
                                value: 50,
                                end_date: '10/11/2021',
                                work_style: 'Remota',
                                regular_user: regularuser,
                                status: 10 })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')
    profile = Profile.create!(freelancer_user_id: freelancer_user.id, fullname: 'Gabriela Martins',
                              socialname: 'Fernando Martins',
                              description: 'Fullstack dev',
                              education: 'Formado em sistemas de informação',
                              birthdate: '14/06/1996',
                              experience: 'Três anos trabalhando na Rebase',
                              freelancer_user: freelancer_user)
    proposal = Proposal.create!(reason: 'Tenho muita curiosidade nesse projeto',
                                value: 50,
                                available_time: 20,
                                expected_end: '11/12/2021',
                                freelancer_user: freelancer_user,
                                project: project,
                                status: 10)

    login_as regularuser, scope: :regular_user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Site para cadastro de imóveis'
    fill_in 'Deixe um feedback', with: 'Ótimo freelancer e muito competente'
    click_on 'Enviar feedback'

    expect(page).to have_content('Feedback enviado com sucesso!')
  end
end
