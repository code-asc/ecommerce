function deleteFromCart(l)
{
  $.ajax({
    type:"POST",
    url:"authentication.cfc?deleteCart",
    data:{val:33},
    success:function(responseText){
      alert(responseText);
    }
  })}
