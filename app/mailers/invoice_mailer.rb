class InvoiceMailer < ApplicationMailer
  layout 'invoice'

  def email_invoice(invoice, user, account_id)
    @invoice = invoice
    @client = @invoice.client
    @user = user
    mail(from: ENV['DEFAULT_FROM_ADDRESS'], reply_to: @user.email, to: @client.email, subject: "Invoice #{@invoice} from #{@invoice.account.name} for #{@client.carer}" )
  end

end
