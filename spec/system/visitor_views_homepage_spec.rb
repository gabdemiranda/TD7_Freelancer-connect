require 'rails_helper'

describe "Visitor visits homepage" do
  it 'and views welcome message' do

  visit root_path
  
  expect(page).to have_content("Freelancer Connect")
  expect(page).to have_content("Contrate o melhor profissional para sua necessidade!")
  
  end

  it 'and views available projects' do
    Project.create!({ title: 'Site para cadastro de imóveis',
                    description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
                    skills: 'Ruby on Rails',
                    value: 50,
                    end_date: '10/11/2021',
                    work_style: 'Remota'
                    })

    visit root_path
    
    expect(page).to have_content("Site para cadastro de imóveis")
    expect(page).to have_content("Valor máximo por hora: 50.0 reais")
    expect(page).to have_content("Habilidades desejadas: Ruby on Rails")
  end

  it 'warns user if there are not any projects available' do

    visit root_path

    expect(page).to have_content("Nenhum projeto disponível")
  end
end
