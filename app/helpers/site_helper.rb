module SiteHelper

  def msg_jumbotron
    case params[:action]
      when 'index'
        "Últimas Questões Cadastradas:"
      when 'questions'
        "Resultado da Pesquisa: \"#{params[:term]}\""
      when 'subject'
        "Questões categorizadas dentro do assunto: \"#{params[:subject]}\""
      end
    end
end
