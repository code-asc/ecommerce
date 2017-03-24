$(document).ready(function(){

$("#password , #email , #mobile").keydown(function(event)
{
  if(event.which==32)
  {
    return false;
  }
});


  $("form[name='cf_form']").submit(function()
{
  //alert("working");
  if(!emailValidate($(this).find("[name='email']").val()))
  {

    $("#row_show_error").html('<div class="alert alert-warning tempDiv"><strong>Invalid Email id....</strong></div>');
    return false;
  }

  //alert("wow....working");
  if($(this).find("[name='password']").val().trim() < 1)
  {

    $("#row_show_error").html('<div class="alert alert-warning tempDiv"><strong>Invalid password....</strong></div>');
    return false;
  }

  if($(this).find("[name='mobile']").val().trim()<10)
  {
    $("#row_show_error").html('<div class="alert alert-warning tempDiv"><strong>Invalid mobile number....</strong></div>')
    return false;
  }

})
});

function emailValidate(email)
{
//var email_validate='^[a-zA-Z_0-9]+@[a-zA-Z]+.[a-zA-Z]{2,8}$';
var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
if(filter.test(email))
{
  return true;
}
else {
  return false;
}
}
