require 'rails_helper'

describe 'as a regular user I can' do
  it 'see project detais' do
    regular_user = RegularUser.create!(email: 'regular@teste.com.br', password: '1234tyy') 
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota',
      regular_user_id: 1
      }) 

    login_as regular_user, scope: :regular_user
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
      
    end

    it 'see button to return to root path' do
      regular_user = RegularUser.create!(email: 'regular@teste.com.br', password: '1234tyy')
      Project.create!( 
        title: 'Site para cadastro de imóveis',
        description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
        skills: 'Ruby on Rails',
        value: 50,
        end_date: '10/11/2021',
        work_style: 'Remota',
        regular_user_id: 1
      )  

      login_as regular_user, scope: :regular_user
      visit root_path
      click_on 'Ir para o projeto'

      expect(page).to have_link('Voltar')
    end

    it 'cannot see button to go to proposal' do
      regular_user = RegularUser.create!(email: 'regular@teste.com.br', password: '1234tyy')
      Project.create!( 
        title: 'Site para cadastro de imóveis',
        description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
        skills: 'Ruby on Rails',
        value: 50,
        end_date: '10/11/2021',
        work_style: 'Remota',
        regular_user_id: 1
      )
      
      login_as regular_user, scope: :regular_user
      visit root_path
      click_on 'Ir para o projeto'

      expect(page).to_not have_link('Fazer proposta')
    end
  end
end