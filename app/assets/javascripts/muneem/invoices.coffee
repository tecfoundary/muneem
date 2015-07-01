$ ->
  $('#invoice_due_at').datepicker format: 'yyyy-mm-dd'
  $('#invoice-list-table').dataTable 'pageLength': 25

  $('#invoice-list-table tbody').on 'click', 'tr', (e)  ->
    redirection = $(this).attr('id')
    document.location.href = redirection
    return

