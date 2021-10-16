require 'rails_helper'

describe 'as a Freelancer I can' do
  it 'see my proposals' do
    regularuser = RegularUser.create!(email: 'tom@user.com.br', password: '123456')
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota',
      regular_user_id: 1
      })
    Project.create!({ title: 'Aplicação para mobile',
       description: 'Uma aplicação não bem definida',
       skills: 'Todas',
       value: 50,
       end_date: '10/11/2021',
       work_style: 'Presencial',
       regular_user_id: 1
       })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
    profile = Profile.create!(freelancer_user_id: freelancer_user.id, fullname: 'Gabriela Martins',
                 socialname: 'Fernando Martins',
                 description: 'Fullstack dev', 
                 education: 'Formado em sistemas de informação',
                 birthdate: '14/06/1996',
                 experience: 'Três anos trabalhando na Rebase',
                 freelancer_user_id: 1
                 )
    proposal = Proposal.create!(reason: 'Tenho muita curiosidade nesse projeto', 
                value: 50,
                available_time: 20,
                expected_end: '11/12/2021',
                freelancer_user_id: 1,
                project_id: 1)

    login_as freelancer_user, scope: :freelancer_user
    visit root_path
    click_on 'Minhas propostas'

    expect(page).to have_content('Site para cadastro de imóveis')
    expect(page).to have_content('Tenho muita curiosidade nesse projeto')
    expect(page).to have_content('Proposta de valor/hora')
    expect(page).to have_content('Horas disponíveis por semana')
    expect(page).to have_content('Expectativa de conclusão do projeto')
    expect(page).to_not have_content('Aplicação para mobile')
  end
end