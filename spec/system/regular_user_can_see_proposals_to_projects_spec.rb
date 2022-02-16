# frozen_string_literal: true

require 'rails_helper'

describe 'as a regular user I can' do
  it 'see proposals made for my project' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    project = Project.create!({ title: 'Site para cadastro de imóveis',
                                description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                                skills: 'Ruby on Rails',
                                value: 50,
                                end_date: '10/11/2021',
                                work_style: 'Remota',
                                regular_user: regularuser })
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
                                project: project)

    login_as regularuser, scope: :regular_user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Site para cadastro de imóveis'

    expect(page).to have_content('Propostas')
    expect(page).to have_content('Proposta de Fernando Martins')
    expect(page).to have_content('Tenho muita curiosidade nesse projeto')
    expect(page).to have_content('Proposta de valor/hora: R$ 50.0')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content('Expectativa de conclusão do projeto')
    expect(page).to_not have_content('Fazer proposta')
  end

  it 'cannot see other users proposals list' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    regularuser2 = RegularUser.create!(email: 'lucas@user.com.br', password: '1234567')
    project = Project.create!({ title: 'Site para cadastro de imóveis',
                                description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                                skills: 'Ruby on Rails',
                                value: 50,
                                end_date: '10/11/2021',
                                work_style: 'Remota',
                                regular_user: regularuser })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')
    profile = Profile.create!(freelancer_user: freelancer_user, fullname: 'Gabriela Martins',
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
                                project: project)

    login_as regularuser2, scope: :regular_user
    visit root_path
    click_on 'Site para cadastro de imóveis'

    expect(page).to_not have_content('Propostas')
    expect(page).to_not have_content('Proposta de Fernando Martins')
    expect(page).to_not have_content('Tenho muita curiosidade nesse projeto')
    expect(page).to_not have_content('Proposta de valor/hora: R$ 50.0')
    expect(page).to_not have_content('Horas disponíveis por semana: 20')
    expect(page).to_not have_content('Expectativa de conclusão do projeto')
    expect(page).to_not have_content('Fazer proposta')
  end

  it 'and can accept a proposal' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    project = Project.create!({ title: 'Site para cadastro de imóveis',
                                description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                                skills: 'Ruby on Rails',
                                value: 50,
                                end_date: '10/11/2021',
                                work_style: 'Remota',
                                regular_user: regularuser })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')
    profile = Profile.create!(freelancer_user: freelancer_user, fullname: 'Gabriela Martins',
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
                                project: project)

    login_as regularuser, scope: :regular_user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Site para cadastro de imóveis'
    click_on 'Aceitar proposta'

    expect(page).to have_content('Propostas')
    expect(page).to have_content('Proposta de Fernando Martins')
    expect(page).to have_content('Tenho muita curiosidade nesse projeto')
    expect(page).to have_content('Proposta de valor/hora: R$ 50.0')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content('Expectativa de conclusão do projeto')
    expect(page).to have_content('Status: Aprovada')
  end

  it 'and can accept a proposal' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    project = Project.create!({ title: 'Site para cadastro de imóveis',
                                description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                                skills: 'Ruby on Rails',
                                value: 50,
                                end_date: '10/11/2021',
                                work_style: 'Remota',
                                regular_user: regularuser })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')
    profile = Profile.create!(freelancer_user: freelancer_user, fullname: 'Gabriela Martins',
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
                                project: project)

    login_as regularuser, scope: :regular_user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Site para cadastro de imóveis'
    click_on 'Rejeitar proposta'

    expect(page).to have_content('Propostas')
    expect(page).to have_content('Proposta de Fernando Martins')
    expect(page).to have_content('Tenho muita curiosidade nesse projeto')
    expect(page).to have_content('Proposta de valor/hora: R$ 50.0')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content('Expectativa de conclusão do projeto')
    expect(page).to have_content('Status: Rejeitada')
  end
end
