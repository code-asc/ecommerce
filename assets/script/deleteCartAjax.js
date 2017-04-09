function deleteFromCart(l)
{
  $.ajax({
    type:"POST",
    url:"/Controller/authentication.cfc?deleteCart",
    data:{val:33},
    success:function(responseText){
      alert(responseText);
    }
  })}
