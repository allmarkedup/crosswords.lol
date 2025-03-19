# Preview all emails at http://localhost:3456/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def failed_import
    error = CrosswordProviderError.new("You blew something up", {html: "<p>404</p>"})
    AdminMailer.with(error:, data: {foo: "bar"}).failed_import
  end

  def failed_import_no_data
    error = CrosswordProviderError.new("You blew something up", {html: "<p>404</p>"})
    AdminMailer.with(error:).failed_import
  end
end
