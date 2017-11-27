// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

const setStateCart = (state) => {
  switch(state) {
    case 'addProduct':
      $('#form_add_product').show()
      $('#grid_products').hide()
      $('#add_product_to_cart').hide()
      break;
    case 'listProducts':
      $('#form_add_product').hide()
      $('#grid_products').show()
      $('#add_product_to_cart').show()
      break;
  }   
}

$( document ).ready(function() {
  $('#add_product_to_cart').click(() => {
    setStateCart('addProduct')
  });  
  $('#form_add_product').find('#cancel').click((e) => {
    e.preventDefault()
    setStateCart('listProducts')
  });
});