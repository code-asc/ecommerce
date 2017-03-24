$(document).ready(function()
{
  $("#onAddCart").click(function()
{

  $.ajax(
    {
    url:'authentication.cfc?method=addToCart',
    success:function(responseText)
    {

      $("#infoAboutCart").html("<div class='alert alert-success'>Added To Cart</div>");
      //alert("works");
    //  console.log($("#traceCount").html());
     val=parseInt($("#traceCount").html())+1;
      $("#traceCount").html(val);
    }
  });

  $(this).attr("disabled",true).text("addedToCart");
});
});
