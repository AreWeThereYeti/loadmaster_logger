class InvoicesController < ApplicationController
  load_and_authorize_resource except: [:create]
  
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  
  helper_method :sort_column, :sort_direction

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.where(:user_id => current_user.id.to_s).order_by([[sort_column, sort_direction]]).page(params[:page]).per(25)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    #@invoice = Invoice.find(params[:id])
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice_nr=Invoice.where(:user_id => current_user.id.to_s).count+1
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id=current_user.id
    @invoice.trips=format_trips(params[:trips])
    @invoice.brutto_price=params[:brutto_price]
    @invoice.netto_price=params[:netto_price]
    @invoice.taxes=params[:taxes]

    respond_to do |format|
      if @invoice.save
        #format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { 
          puts 'success ran'
          render json: {:redirect_url => '/invoices/'+@invoice.id.to_s}, status: :created 
          #render action: 'show', status: :created, location: @invoice 
        }
      else
      	puts 'error ran'
        #format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end
  
  def search
    if params[:search].empty? || params[:search][0].empty?
      redirect_to invoices_path
    else
      @invoices = sort_search_results(string_search(params[:search],Invoice,max_search_results))
      render 'index'
    end
  end
  
  def render_pdf   
    render :pdf => "my_file_name",
           :template => 'invoices/show.pdf.html.erb',
           :layout => 'pdf.html.erb',
           :show_as_html => params[:debug].present?      # allow debuging bas
  end
  
  def render_pdfs 
    @invoices = Trip.find(params[:ids])
    render :pdf => "my_file_name",
           :template => 'invoices/show_multiple.pdf.html.erb',
           :layout => 'pdf.html.erb'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(
        :timestamp, 
        :hauler_id, 
        :price, 
        :costumer, 
        :description, 
        :due_date, 
        :cvr, 
        :commentary, 
        :end_note, 
        :invoice_number, 
        :sales_taxes,
        :company_name, 
        :company_street, 
        :company_phone, 
        :company_phone_mobile, 
        :company_phone_mobile,
        :company_bank_reg_nr, 
        :company_bank_account_nr,
        :costumer_name, 
        :costumer_contact_name, 
        :costumer_address_street, 
        :costumer_postal_code, 
        :costumer_city,
        :netto_price,
        :brutto_price,
        :taxes,
        :trips => [])
    end
    
    def sort_column
      Invoice.fields.keys.include?(params[:sort]) ? params[:sort] : 'timestamp'
    end
    
    def format_trips(trips)
      puts 'trips: '
      puts trips
      formatted_trips=[]
      trips.each_with_index{ |(key,value),index|
        value.delete('$$hashKey')
        formatted_trips.push(value)
      }
      puts formatted_trips
      return formatted_trips
    end
end
