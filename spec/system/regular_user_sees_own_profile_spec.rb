require 'rails_helper'

describe 'Regular user sees own profile' do
  it 'from menu' do
    regularuser = RegularUser.create!(email: 'teste@usuario.com.br', password: '15s885')
    
    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'E-mail', with: regularuser.email
    fill_in 'Senha', with: regularuser.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'teste@usuario.com.br'

    expect(page).to have_content('Meu perfil')
    expect(page).to have_content('teste@usuario.com.br')
    expect(current_path).to eq my_profile_path
  end
end