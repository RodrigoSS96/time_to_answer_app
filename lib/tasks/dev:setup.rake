namespace :dev do

  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Restaurar a base de dados da aplicação"
  task setup: :environment do

    if Rails.env.development?

      showSpinner('Excluindo Model (db:drop)') {%x(rails db:drop)}
      showSpinner('Criando nova Model (db:create)') {%x(rails db:create)}
      showSpinner('Executando Migrations (db:migrate)') {%x(rails db:migrate)}
      showSpinner('Criando usuário ADMIN PADRÃO') {%x(rails dev:add_default_admin)}
      showSpinner('Criando usuários ADMIN') {%x(rails dev:add_extra_admins)}
      showSpinner('Criando usuário USER') {%x(rails dev:add_default_user)}
      showSpinner('Cadastrando Assuntos') {%x(rails dev:add_subjects)}
      showSpinner('Cadastrando Perguntas e Respostas') {%x(rails dev:add_answer_and_questions)}
      #%x(rails dev:add_mining_types)
      #%x(rails dev:add_coins)
    end
  end

  desc "Criar usuário Admin Padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com.br',
      password:102030,
      password_confirmation:102030
    )
  end

  desc "Criar usuários Admin"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password:102030,
        password_confirmation:102030
      )
    end
  end

  desc "Criar usuário User"
  task add_default_user: :environment do
    User.create!(
      first_name: 'default user name',
      email: 'user@user.com.br',
      password:102030,
      password_confirmation:102030
    )
  end

  desc "Adicionar Assuntos Padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Realizar a Contagem de Questões Categorizadas por Assunto"
  task reset_subject_counter: :environment do
    showSpinner('Realizando a contagem de questões categorizadas por assunto') do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end


  desc "Adicionar Perguntas e Respostas Padrões"
  task add_answer_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|

        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        elect_true_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  private #O private indica que esse método so pode ser utilizado dentro desse namespace

    def create_question_params(subject = Subject.all.sample)
      {
        question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject,
          answers_attributes: []
        }
      }
    end

    def add_answers(answers_array = [])
      rand(2..5).times do |x|
        answers_array.push(create_answer_params)
      end
    end

    def create_answer_params(correct = false)
      {description: Faker::Lorem.sentence, correct: correct}
    end

    def elect_true_answer(answers_array = [])
      index = rand(answers_array.size)
      answers_array[index] = create_answer_params(true)
    end

    def showSpinner(start_msg, end_msg = " > Concluído com Sucesso!")
        spinner = TTY::Spinner.new("[:spinner] #{start_msg}", format: :spin_2)
        spinner.auto_spin
        yield
        spinner.success("#{end_msg}")
    end
end