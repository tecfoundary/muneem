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

    respond_to do |format|
      if @invoice.save!
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
      else
        format.html { 
          notify_now :error, ::I18n.t('messages.resource.not_valid',
            :type     => Invoice.model_name.human,
            :errors   => @invoice.errors.full_messages.to_sentence
          )
          redirect_to action: :show, controller: :clients, id: invoice_params.slice(:client_id)[:client_id], :status => 422 
        }
        format.json {
          render json: {:error => @invoice.errors.full_messages.to_sentence}, status: 422
        }
      end
    end
  end  

  def email
    InvoiceMailer.email_invoice(@invoice, current_user).deliver_later!
    notify :notice, ::I18n.t('messages.resource.messaged',
      :type       => @invoice.client.email,
      :resource   => @invoice
    )
    redirect_to action: :show, id: @invoice 
  end

  def print
  end

  def update
    @invoice.update_attributes invoice_params
    @invoice.save!

    respond_to do |format|
      format.html { 
        notify :notice, ::I18n.t('messages.resource.updated',
          :type       => Invoice.model_name.human,
          :resource   => @invoice
        )
        render action: :show, id: @invoice 
      }
      format.json {
        render json: @invoice
      }
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique, ActiveRecord::RecordNotSaved => e
    respond_to do |format|
      format.html { 
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Invoice.model_name.human,
          :errors   => @invoice.errors.full_messages.to_sentence
        )
        redirect_to action: :show, :status => 422 
      }
      format.json {
        render json: {:error => @invoice.errors.full_messages.to_sentence}, status: 422
      }
    end
  end  

  private


  def invoice_params
    params.require(:invoice).permit(:client_id, :due_at, :tax_rate, :shipping, :order_id, 
      items_attributes: [:product, :reference, :description, :quantity, :cost, :discount, :account_id],
      payments_attributes: [:amount, :reference, :at, :account_id])
  end

end
