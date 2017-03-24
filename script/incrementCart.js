$(document).ready(function(){

  $(".increment").click(function(event){
    var detailID=$(this).attr("value");


    $.ajax({
      url:'authentication.cfc?method=incrementQuantity',
      data:{id:JSON.stringify(detailID) },
      success:function(responseText)
      {

        $.each(JSON.parse(responseText),function(index,val){
          $.each(val,function(index,key)
        {
          if(index=="QUANTITY"){
$("#"+detailID).html(key);
}
else if (index=="SUM") {
$("#totalPriceAll").text(key);
}
else if(index=="TOTALCART")
{
  $("#traceCount").text(key);
}
else {
  $("#"+detailID+"paraID").html("Total:Rs.<strong><span id="+detailID+"SingleProduct"+">"+key+"</span></strong>");

}

        })
      })
      }
    })


  });
})
