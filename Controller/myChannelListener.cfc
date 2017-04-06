component extends="CFIDE.websocket.ChannelListener"
{

public any function beforePublish(any message, Struct publisherInfo)
      {
           return message;
      }
}
