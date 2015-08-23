class InvoiceMailer < ApplicationMailer
  layout 'invoice'

  def email_invoice(invoice, user, account)
    @invoice = Invoice.by_account(account).find(invoice)
    @client = @invoice.client
    @user = User.by_account(account).find(user)
    mail(reply_to: @user.email, to: @client.email, subject: "Invoice #{@invoice} from #{@invoice.account.name} for #{@client.carer}" )
  end

end
