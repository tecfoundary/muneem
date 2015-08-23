class InvoiceMailer < ApplicationMailer
  layout 'invoice'

  def email_invoice(invoice, user)
    @invoice = invoice
    @client = @invoice.client
    @user = user
    mail(reply_to: @user.email, to: @client.email, subject: "Invoice #{@invoice} from #{@invoice.account.name} for #{@client.carer}" )
  end

end
