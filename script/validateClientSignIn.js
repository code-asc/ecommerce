$(document).ready(function(){

  $("#password , #email").keydown(function(event)
  {
    if(event.which==32)
    {
      return false;
    }
  });

  $.validator.setDefaults({
    errorClass:"help-block",
    highlight:function(element){
      $(element).closest(".form-group").addClass("has-error");
    },
    unhighlight:function(element)
    {
      $(element).closest(".form-group").removeClass("has-error");
    }
  });
  $("#cf_form_signin").validate({
    rules:{
      email:{
        required:true,
        email:true
      },
      password:{
        required:true
      }
    },
    messages:{
      email:{
        required:"Please enter an email address",
        email:"Please enter a valid email address"
      },
      password:{
        required:"Please enter the password"
      }
    }
  });
});
