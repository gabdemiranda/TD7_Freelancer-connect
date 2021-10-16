require 'rails_helper'

describe 'as a Freelancer I can' do
  it 'send a proposal' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota',
      regular_user_id: 1
      })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
    profile = Profile.create!(freelancer_user_id: freelancer_user.id, 
                fullname: 'Gabriela Martins', 
                socialname: 'Fernando Martins',
                description: 'Fullstack dev', 
                education: 'Formado em sistemas de informação',
                birthdate: '14/06/1996', 
                experience: 'Três anos trabalhando na Rebase'
                )

    login_as freelancer_user, scope: :freelancer_user
    visit root_path
    click_on 'Ir para o projeto'
    click_on 'Fazer proposta'
    fill_in 'Por que você quer trabalhar nesse projeto?', with: 'Porque entendo dessa linguagem'
    fill_in 'Proposta de valor/hora', with: 50
    fill_in 'Horas disponíveis por semana', with: 20
    fill_in 'Expectativa de conclusão do projeto', with: '14/11/2021'
    click_on 'Enviar'

    expect(page).to have_content('Proposta realizada com sucesso!')
    expect(page).to have_content('Porque entendo dessa linguagem')
    expect(page).to have_content('Proposta de valor/hora')
    expect(page).to have_content('Horas disponíveis por semana')
    expect(page).to have_content('Expectativa de conclusão do projeto')
  end
end