require 'rails_helper'

describe 'as regular user' do
  it 'successfully' do
    regular_user = RegularUser.create!(email: 'janice@teste.com.br', password: '123456789')

    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'Email', with: regular_user.email
    fill_in 'Senha', with: regular_user.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).to have_content(regular_user.email)
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Cadastrar projeto')
  end

  it 'and logs out' do
    regular_user = RegularUser.create!(email: 'janice@teste.com.br', password: '123456789')

    login_as regular_user, scope: :regular_user
    visit root_path
    click_on 'Logout'

    expect(page).to have_content('Saiu com sucesso')
    expect(page).to_not have_content(regular_user.email)
    expect(page).to_not have_link('Logout')
    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Cadastrar projeto')
  end

  it 'and must fill all information' do
    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Email ou senha inválida.')
  end

end