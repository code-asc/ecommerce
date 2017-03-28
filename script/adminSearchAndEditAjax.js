$(document).ready(function(){
  $("input[name='submitEditProduct']").click(function(event){
    if($("#editProductAdmin").valid())
    {
      submitEditProductAJAXCall();
    }
  })
})

function submitEditProductAJAXCall()
{
  $("#infoAboutEdit").empty();

  var productID=$("#productID").val();
  var categoryID=$("#category").val();
  var subcategoryID=$("#subcategory").val();
  var unitPrice=$("#unitPrice").val();
  var stock=$("#stock").val();
  var discount=$("#discount").val();
  var thumbNail=$("#thumbNailText").val();
  var largePhoto=$("#largePhotoText").val();
  var productDesc=$("#productDesc").val();

  $.ajax({
    url:"adminData.cfc?method=editProductRemote",
    data:{productID:productID,productDesc:productDesc,unitPrice:unitPrice,unitInStock:stock,discount:discount,thumbNailPhoto:thumbNail,largePhoto:largePhoto},
    success:function(responseText){
      if(responseText==1){
      $("#infoAboutEdit").append("<div class='alert alert-success'>Change Saved</div>").delay(4000).fadeOut();

    }

      else {
        $("#infoAboutEdit").append("<div class='alert alert-success'>Something went wrong</div>");
      }
    },
    error:function(e)
    {
        $("#infoAboutEdit").append("<div class='alert alert-success'>Error</div>")
    }
  });
}
