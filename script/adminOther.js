$(document).ready(function(){
  $("#addBrand").click(function(event){

    if($("#formOtherBrand").valid())
    {
      $.ajax({
        url:"adminData.cfc?method=addBrand",
        data:{brandName:$("#brandName").val()},
        success:function(responseText){
          $("#formOtherData").append("<div class='alert alert-success'>New Brand added to Database</div>").delay(4000).fadeOut();
        },
        error:function(err){
          $("#formOtherData").append("<div class='alert alert-success'>Something went wrong :( </div>").delay(4000).fadeOut();
        }
      })
    }
  });

  $("#addCategory").click(function(event){

    if($("#formOtherCategory").valid())
    {
      $.ajax({
        url:"adminData.cfc?method=addCategory",
        data:{categoryType:$("#category").val()},
        success:function(responseText){
          $("#formOtherData").append("<div class='alert alert-success'>New Category added to Database</div>").delay(4000).fadeOut();
        },
        error:function(err){
          $("#formOtherData").append("<div class='alert alert-success'>Something went wrong :( </div>").delay(4000).fadeOut();
        }
      })
    }
  })
});
