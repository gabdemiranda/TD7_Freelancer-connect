require 'rails_helper'

describe 'Visitor registers new project' do
  it 'successfully' do
    regular_user = RegularUser.create!(email: 'gabriel@life.com.br', password: '159753')

    login_as regular_user, scope: :regular_user
    visit root_path
    click_on 'Cadastrar Projeto'

    fill_in 'Título', with: 'Site de lançamentos espaciais'
    fill_in 'Descrição', with: 'Site que armazena dados de lançamentos espaciais'
    fill_in 'Habilidades desejadas', with: 'Ruby on Rails'
    fill_in 'Atuação', with: 'Presencial'
    fill_in 'Valor máximo por hora', with: 80
    fill_in 'Data limite', with: '12/12/2021'
    click_on 'Enviar'

    expect(page).to have_content('Site de lançamentos espaciais')
    expect(page).to have_content('Site que armazena dados de lançamentos espaciais')
    expect(page).to have_content("Habilidades desejadas: Ruby on Rails")
    expect(page).to have_content("Atuação Presencial")
    expect(page).to have_content("Valor máximo por hora: R$ 80,00")
    expect(page).to have_content("Data Limite")
  end
end