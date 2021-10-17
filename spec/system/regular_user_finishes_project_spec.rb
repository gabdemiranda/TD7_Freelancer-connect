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
      regular_user_id: 1
      })

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
end