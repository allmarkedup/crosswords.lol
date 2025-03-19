class AdminMailer < ApplicationMailer
  default from: email_address_with_name("#{Rails.application.credentials.mailgun.from}@#{Rails.application.credentials.mailgun.domain}", "Crosswords.lol support elf")
  default to: Rails.application.credentials.mailgun.to

  def failed_import
    @error = params[:error]
    @context = params[:context]
    @data = params[:data]
    mail(subject: "Failed import 😢")
  end
end
