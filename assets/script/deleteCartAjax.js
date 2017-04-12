function deleteFromCart(l)
{
  $.ajax({
    type:"POST",
    url:"/Controller/authentication.cfc?deleteCart",
    data:{val:33},

  }).fail(function(jqXHR,textStatus,errorThrown){
    console.log(jqXHR.responseText);
  })
}
