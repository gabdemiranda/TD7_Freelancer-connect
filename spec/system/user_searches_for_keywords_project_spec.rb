require 'rails_helper'

describe "user searches for keywords" do
  it 'successfully' do
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota'
      })
    Project.create!({ title: 'Aplicação para celular',
      description: 'Preciso de uma aplicação para gerenciar meus alunos de academia',
      skills: 'Python',
      value: 30,
      end_date: '10/12/2021',
      work_style: 'Presencial'
      })
  
    visit root_path
    fill_in "Pesquisar projetos:", with: "Aplicação para celular"
    click_on "Pesquisar"

    expect(page).to have_content("Aplicação para celular")
    expect(page).to have_content("Preciso de uma aplicação para gerenciar meus alunos de academia")
    expect(page).to have_content("Habilidades desejadas: Python")
    expect(page).to_not have_content("Site para cadastro de imóveis")
    expect(page).to_not have_content("Preciso de um site que cadastre imóveis de vários tipos e em várias locações")
    expect(page).to_not have_content("Ruby on Rails")
  end
end
