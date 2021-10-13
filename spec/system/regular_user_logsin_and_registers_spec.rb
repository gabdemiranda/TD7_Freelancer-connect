require 'rails_helper'

describe 'as regular user' do
  it 'successfully logs in' do
    regular_user = RegularUser.create!(email: 'janice@teste.com.br', password: '123456789')

    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'E-mail', with: regular_user.email
    fill_in 'Senha', with: regular_user.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content(regular_user.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Cadastrar projeto')
  end

  it 'logs out' do
    regular_user = RegularUser.create!(email: 'janice@teste.com.br', password: '123456789')

    login_as regular_user, scope: :regular_user
    visit root_path
    click_on 'Logout'

    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to_not have_content(regular_user.email)
    expect(page).to_not have_link('Logout')
    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Cadastrar projeto')
  end

  it 'you must fill all information' do
    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('E-mail ou senha inválidos.')
  end

  it 'registers new regular user' do
    visit root_path
    click_on 'Entrar como usuário'
    click_on 'Registrar-se como usuário'
    fill_in 'E-mail', with: 'teste@usuario.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_button 'Registrar'

    expect(page).to have_content('Você realizou seu registro com sucesso')
  end
end
