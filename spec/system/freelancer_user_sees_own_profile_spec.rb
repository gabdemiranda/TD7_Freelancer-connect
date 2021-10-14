require 'rails_helper'

describe 'Freelancer user sees profile page' do
  it 'from menu' do
    freelanceruser = FreelancerUser.create!(email: 'teste@freelancer.com.br', password: '15s885')
    
    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'E-mail', with: freelanceruser.email
    fill_in 'Senha', with: freelanceruser.password
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'teste@freelancer.com.br'

    expect(page).to have_content('Meu perfil')
    expect(page).to have_content('teste@freelancer.com.br')
    expect(current_path).to eq my_profile_path
  end

  it 'fill in profile info' do
    freelanceruser = FreelancerUser.create!(email: 'teste@freelancer.com.br', password: '15s885')
      
    login_as freelanceruser, scope: :freelancer_user
    visit root_path
    click_on 'teste@freelancer.com.br'
    click_on 'Editar perfil'
    fill_in 'Nome completo', with: 'Freelancer primeiro'
    fill_in 'Nome social', with: 'Freelancxr'
    fill_in 'Data de nascimento', with: '14/06/1996'
    fill_in 'Formação', with: 'Formado em TI'
    fill_in 'Descrição', with: 'Muito competente e com vários anos de experiência'
    fill_in 'Experiência', with: '3 anos de Ruby on Rails'
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Freelancer primeiro')
    expect(page).to have_content('Freelancxr')
    expect(page).to have_content('14/06/1996')
    expect(page).to have_content('Formado em TI')
    expect(page).to have_content('Muito competente e com vários anos de experiência')
    expect(page).to have_content('3 anos de Ruby on Rails')
  end
end