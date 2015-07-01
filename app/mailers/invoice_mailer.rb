class InvoiceMailer < ApplicationMailer
  layout 'invoice'

  def email_invoice(invoice_id, user_id, account_id)
    @invoice = Invoice.where(id: invoice_id, account: account_id).first
    @client = @invoice.client
    @user = User.where(id: user_id, account: account_id).first
    mail(from: @user.email, to: @client.email, subject: "Invoice #{@invoice} from #{@invoice.account.name} for #{@client.carer}" )
  end

end
