# frozen_string_literal: true

require 'rails_helper'

describe 'Freelancer logs in' do
  it 'successfully' do
    freelancer = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')

    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'E-mail', with: freelancer.email
    fill_in 'Senha', with: freelancer.password
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content(freelancer.email)
    expect(page).to have_link('Logout')
    expect(page).to have_link('Complete seu perfil')
  end

  it 'and must fill all information' do
    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    within 'form' do
      click_on 'Entrar'
    end

    expect(page).to have_content('E-mail ou senha inválidos')
  end

  it 'and logs out' do
    freelancer = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')

    login_as freelancer, scope: :freelancer_user
    visit root_path
    click_on 'Logout'

    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to_not have_content(freelancer.email)
    expect(page).to_not have_link('Logout')
    expect(page).to have_link('Entrar como freelancer')
    expect(page).to_not have_link('Cadastrar projeto')
  end

  it 'registers new freelancer user' do
    visit root_path
    click_on 'Entrar como freelancer'
    click_on 'Registrar-se como freelancer'
    fill_in 'E-mail', with: 'teste@ufreelancer.com'
    fill_in 'Senha', with: '123sd456'
    fill_in 'Confirme sua senha', with: '123sd456'
    click_button 'Registrar'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
  end

  it 'fails to register with empty fields' do
    visit root_path
    click_on 'Entrar como freelancer'
    click_on 'Registrar-se como freelancer'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_button 'Registrar'

    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end
end
