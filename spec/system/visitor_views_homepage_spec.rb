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

  it 'and warns user if there are not any projects available' do

    visit root_path

    expect(page).to have_content("Nenhum projeto disponível")
  end

  it 'and shows all the information when user clicks on the project' do
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota'
      })

    visit root_path
    click_on "Site para cadastro de imóveis"

    expect(page).to have_content("Site para cadastro de imóveis")
    expect(page).to have_content("Preciso de um site que cadastre imóveis de vários tipos e em várias locações")
    expect(page).to have_content("Data limite: 2021-11-10")
    expect(page).to have_content("Atuação Remota")
    expect(page).to have_content("Valor máximo por hora: R$ 50,00")
    expect(page).to have_content("Habilidades desejadas: Ruby on Rails")
  end

  it 'and view property details and return to home page' do
    Project.create!({ title: 'Site para cadastro de imóveis',
      description: 'Preciso de um site que cadastre imóveis de vários tipos e em várias locações',
      skills: 'Ruby on Rails',
      value: 50,
      end_date: '10/11/2021',
      work_style: 'Remota'
      })

    visit root_path
    click_on 'Site para cadastro de imóveis'
    click_on 'Voltar'

    expect(current_path).to eq root_path
    expect(page).to have_text('Site para cadastro de imóveis')
    expect(page).to have_text('Habilidades desejadas: Ruby on Rails')
  end
end
