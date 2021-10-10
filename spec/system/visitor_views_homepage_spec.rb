require 'rails_helper'

describe "Visitor visits homepage" do
  it 'and views welcome message' do

  visit root_path
  
  expect(page).to have_content("Freelancer Connect")
  expect(page).to have_content("Contrate o melhor profissional para sua necessidade!")
  
  end
end
