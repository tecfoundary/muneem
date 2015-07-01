class Users::InvoicesController < Users::BaseController

  # skip_before_filter :verify_authenticity_token, :only => [:create]
  
  before_action :load_resource, except: [
    :create,
    :index,
    :new
  ]

  before_filter :load_resources, :only => [
    :index,
  ]

  # Must be called after load_recource filter.
  before_filter :check_resource_params, :only => [
    :create,
    :update,
  ]


  def create
    @invoice = Invoice.new invoice_params.except(:shift_ids)
    @invoice.account = current_account
    @invoice.save!

    respond_to do |format|
      format.html { 
        notify :notice, ::I18n.t('messages.resource.created',
          :type       => Invoice.model_name.human,
          :resource   => @invoice
        )
        render action: :show, id: @invoice 
      }
      format.json {
        render json: @invoice
      }
    end
  rescue Mongoid::Errors::Validations => e
    respond_to do |format|
      format.html { 
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Client.model_name.human,
          :errors   => @client.errors.full_messages.to_sentence
        )
        render action: :new, id: @client, :status => 422 
      }
      format.json {
        render json: {:error => @client.errors.full_messages.to_sentence}, status: 422
      }
    end

  end  
  def new
  end

  def show
  end

  def print
  end

  def email
    InvoiceMailer.email_invoice(@invoice.id.to_s, current_user.id.to_s, current_user.account.id.to_s).deliver_later!
    notify :notice, ::I18n.t('messages.resource.emailed',
      :type       => @invoice.client.email,
      :resource   => @invoice
    )
    redirect_to action: :show, id: @invoice 
  end

  private


  def invoice_params
    params.require(:invoice).permit(:client_id, :due_at, :tax_rate, :shipping, items_attributes: [:product, :reference, :description, :quantity, :cost, :paid])
  end

end
