require 'rails_helper'

describe 'as a Freelancer I can' do
  it 'see project detais' do
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota'
      })
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
    profile = Profile.create!(freelancer_user_id: freelancer_user.id, fullname: 'Gabriela Martins', socialname: 'Fernando Martins',
      description: 'Fullstack dev', education: 'Formado em sistemas de informação',
      birthdate: '14/06/1996', experience: 'Três anos trabalhando na Rebase'
      )

    login_as freelancer_user, scope: :freelancer_user
    visit root_path
    click_on 'Ir para o projeto'

    expect(page).to have_content("Site para cadastro de imóveis")
    expect(page).to have_content("Preciso de um site que cadastre imóveis de vários tipos e em várias locações")
    expect(page).to have_content("Data limite: 2021-11-10")
    expect(page).to have_content("Atuação Remota")
    expect(page).to have_content("Valor máximo por hora: R$ 50.0")
    expect(page).to have_content("Habilidades desejadas: Ruby on Rails")
  end

  context 'see buttons to' do
    before do
      Project.create!( 
        title: 'Site para cadastro de imóveis',
        description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
        skills: 'Ruby on Rails',
        value: 50,
        end_date: '10/11/2021',
        work_style: 'Remota'
      )
      freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
      profile = Profile.create!(
        freelancer_user_id: freelancer_user.id, 
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
    end

    it 'return to root path' do
      expect(page).to have_link('Voltar')
    end

    it 'go to proposal' do
      expect(page).to have_link('Fazer proposta')
    end
  end

  it 'make a proposal' do
    Project.create!( 
      title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota'
    )
    freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
    profile = Profile.create!(
      freelancer_user_id: freelancer_user.id, 
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

    expect(current_path).to eq new_proposal_path
  end

end