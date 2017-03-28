var msgHandler=function(message)
{
  var dataSocket=message.data;
  var postTime;
  var content;
  if(dataSocket)
  {
    $(".notifications-wrapper").empty();
    $.ajax({
      url:"adminData.cfc?method=notificationData",
      data:{content:dataSocket},
      success:function(responseText){
        console.log(responseText);
        $.each(JSON.parse(responseText),function(index,key){
          $.each(key,function(index,value){
          if(index=="POSTTIME")
          {
            postTime=value;
          }
          else if (index=="CONTENT") {
            content=value;
          }
          })

  $(".notifications-wrapper").append(' <a class="content" href="#"><div class="notification-item"><h4 class="item-title">'+postTime+'ago</h4><p class="item-info">'+content+'</p></div></a>')

        })
      }

    })
  }
}

var openHandler=function()
{

}
