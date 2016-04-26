// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require underscore
//= require gmaps/google
//= require rails.validations
//= require rails.validations.simple_form
//= require rails.validations.nested_form
//= require jquery_nested_form
//= require_tree .

$.ajaxSettings.dataType = 'script';


$.fn.is_valid = function () {
    var form = this;
    form_validators = ClientSideValidations.forms[form.attr('id')].validators;
    return form.isValid(form_validators);
};

MyUtils = {
    UpdatePreview: function (obj) {
        // if IE < 10 doesn't support FileReader
        if (!window.FileReader) {
            // don't know how to proceed to assign src to image tag
        } else {
            var reader = new FileReader();
            var target = null;
            var container = $(obj).attr('data-image-preview') || $(obj).parent().find('img') || $(obj).prev('img');
            container = container.length <= 0 ? $(obj).parent().parent().find('img') : container;
            reader.onload = function (e) {
                target = e.target || e.srcElement;
                $(container).attr("src", target.result);
            };
            reader.readAsDataURL(obj.files[0]);
        }
    }
};

$(document).on('change', 'input[data-image-preview]', function(){
    var el = $(this);
    if (el.val() != "") {
        $(el.data('checkbox')).attr('checked', false);
    }
    MyUtils.UpdatePreview(this);
});


$('form').on('nested:fieldAdded', function (event) {
    $(event.target).find(':input').enableClientSideValidations();
});
