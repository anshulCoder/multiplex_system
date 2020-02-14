// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .



function addScreenFields(content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_screens", "g");
  var parent_section = $('.screens_fields .add_fields_btn').append(content.replace(regexp, new_id));
  $(parent_section).find('.remove_fields_btn').not(":first").show();
}

function removeScreensFields(link) {
  parent_section = $(link).parents('.form-row');
  destroy_field = parent_section.find("input[type='hidden'][id$='_destroy']");
  if( destroy_field.length > 0 ) {
    destroy_field.attr('value', '1');
    parent_section.hide();
  } else {
    parent_section.remove();
  }
}

function getListBasedOnSearch(obj, url){
  var search = $(obj).val();
  data = {search: search}
  $.ajax({
    url: url,
    dataType: 'script',
    data: data,
    type: 'Get'
  });
}

function fetchSeats(screen_id, url)
{
  data = {screen_id: screen_id}
  $.ajax({
    url: url,
    dataType: 'script',
    data: data,
    type: 'post'
  });
}

function validateUser(url)
{
  var email = $('.user-wrapper #user_email').val().trim();
  var phone_num = $('.user-wrapper #user_phone_number').val().trim();

  if(email !== '' && phone_num !== '')
  {
    var data = {email: email, phone_number: phone_num};
    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'json',
      data: data,
      success: function(data) {
        if(data.new_record)
        {
          $('.user-wrapper .referral-wrapper').removeClass('d-none');
        }
        $('.user-wrapper').append('<input type="hidden" name="user_id" value="'+data.user_id+'"/>');
        $('.user-wrapper .booking-btn').removeClass('d-none');
        $('.user-wrapper .validate-user-btn').addClass('d-none');
      },
      error: function() {
        alert("Error Validating User!");
      }
    });
  }
}

function validateReferral(url)
{
  var ref_email = $('.user-wrapper #user_referral').val().trim();

  if(ref_email !== '')
  {
    var data = {email: ref_email};
    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'json',
      data: data,
      success: function(data) {
        ref_text = "Referral Not Found";
        if(data.status == true)
        {
          ref_text = "Referral Found";
          $('.user-wrapper .referral-wrapper').append('<input type="hidden" name="user_ref_id" value="'+data.user_ref_id+'"/>');
        }
        $('.user-wrapper .referral-wrapper #referral-result').html(ref_text);
        
      },
      error: function() {
        alert("Error Validating User!");
      }
    });
  }
}