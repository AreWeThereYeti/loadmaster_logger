require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, invoice: { commentary: @invoice.commentary, costumer: @invoice.costumer, cvr: @invoice.cvr, description: @invoice.description, due_date: @invoice.due_date, end_note: @invoice.end_note, hauler_id: @invoice.hauler_id, invoice_number: @invoice.invoice_number, price: @invoice.price, sales_taxes: @invoice.sales_taxes, timestamp: @invoice.timestamp, trips: @invoice.trips }
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should show invoice" do
    get :show, id: @invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice
    assert_response :success
  end

  test "should update invoice" do
    patch :update, id: @invoice, invoice: { commentary: @invoice.commentary, costumer: @invoice.costumer, cvr: @invoice.cvr, description: @invoice.description, due_date: @invoice.due_date, end_note: @invoice.end_note, hauler_id: @invoice.hauler_id, invoice_number: @invoice.invoice_number, price: @invoice.price, sales_taxes: @invoice.sales_taxes, timestamp: @invoice.timestamp, trips: @invoice.trips }
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_redirected_to invoices_path
  end
end
