require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  context 'New proposal' do
    it 'should alert project owner' do
        regularuser = RegularUser.create!(email: 'gabriel@customer.com.br', password: '123456789')
        project = Project.create!({ title: 'Aplicação para mobile',
                                    description: 'Uma aplicação não bem definida',
                                    skills: 'Todas',
                                    value: 50,
                                    end_date: '10/11/2021',
                                    work_style: 'Presencial',
                                    regular_user: regularuser
                                    })
      freelancer_user = FreelancerUser.create!(email: 'freelancer@teste.com.br', password: '1234tyy')  
      profile = Profile.create!(freelancer_user_id: freelancer_user.id, fullname: 'Gabriela Martins',
                                socialname: 'Fernando Martins',
                                description: 'Fullstack dev', 
                                education: 'Formado em sistemas de informação',
                                birthdate: '14/06/1996',
                                experience: 'Três anos trabalhando na Rebase',
                                freelancer_user: freelancer_user
                               )
      proposal = Proposal.create!(reason: 'Tenho muita curiosidade nesse projeto', 
                                  value: 50,
                                  available_time: 20,
                                  expected_end: '11/12/2021',
                                  freelancer_user: freelancer_user,
                                  project: project)

      mail = ProposalMailer.with(proposal: proposal).notify_new_proposal()

      expect(mail.to).to eq ['gabriel@customer.com.br']
      expect(mail.from).to eq ['contato@freelancerconnect.com.br']
      expect(mail.subject).to eq 'Nova proposta para seu projeto'
      expect(mail.body).to include "Seu projeto Aplicação para mobile teve uma nova proposta por Fernando Martins."
    end
  end
end