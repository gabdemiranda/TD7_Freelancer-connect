require 'rails_helper'

describe 'Freelancer logs in' do
    it 'successfully' do
      freelancer = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')

      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: freelancer.email
      fill_in 'Senha', with: freelancer.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content(freelancer.email)
      expect(page).to have_link('Logout')
      expect(page).to have_link('Cadastrar projeto')
    end

    it 'and must fill all information' do
      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Email ou senha inválida.')
    end

    it 'and logs out' do
      freelancer = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')

      login_as freelancer, scope: :freelancer_user
      visit root_path
      click_on 'Logout'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to_not have_content(freelancer.email)
      expect(page).to_not have_link('Logout')
      expect(page).to have_link('Entrar como freelancer')
      expect(page).to_not have_link('Cadastrar projeto')
    end
  end