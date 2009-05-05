package talk {
    import mx.core.UIComponent;
    import flash.external.ExternalInterface;
    import flash.media.Camera;
    import flash.media.Microphone;
    import flash.media.Video;
    import flash.system.SecurityPanel;
    import flash.system.Security;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.events.NetStatusEvent;
    import flash.events.StatusEvent;

    public class VideoScreen extends UIComponent {
        private var camera:Camera;
        private var mic:Microphone;
        private var videoReceived:Video;
        private var nc:NetConnection = new NetConnection();
        private var stream:NetStream;
        private var receiveStream:NetStream;
        
        public function VideoScreen():void {
            super();
            camera = Camera.getCamera();
            mic = Microphone.getMicrophone();
            Security.showSettings(SecurityPanel.PRIVACY);
            if (camera != null) {
                camera.addEventListener(StatusEvent.STATUS, statusHandler);
            } else {
                //handle not having a camera here
            }
        }
        private function statusHandler(event:StatusEvent):void {
            if (event.code == "Camera.Unmuted") {
                connectCamera();
                camera.removeEventListener(StatusEvent.STATUS, statusHandler);
            }
        }

        private function connectCamera():void {
            var video:Video = new Video(160, 120);
            camera.setMode(480, 360, 10);
            video.attachCamera(camera);
            mic.setSilenceLevel(0);
            mic.setUseEchoSuppression(true);
            
            videoReceived = new Video(480, 360);
            addChild(videoReceived);
            addChild(video);
            
            video.x = 470;
            video.y = 230;
            video.width = 160;
            video.height = 120;
            video.scaleX = -1 * video.scaleX;
            videoReceived.x = 0;
            videoReceived.y = 0;
            videoReceived.width = 480;
            videoReceived.height = 360;
            
            nc.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
            var rtmp:String = root.loaderInfo.parameters.rtmp;
            nc.connect(rtmp);
        }
        private function netStatusHandler(event:NetStatusEvent):void {
            if(event.info.code=="NetConnection.Connect.Success") {
                var who:String = root.loaderInfo.parameters.who;
                var opposite:String = who == "me" ? "you" : "me";
                stream = new NetStream(nc);
                receiveStream = new NetStream(nc);
                stream.attachCamera(camera);
                stream.attachAudio(mic);
                stream.publish(who, 'live');
                receiveStream.play(opposite);
                videoReceived.attachNetStream(receiveStream);
            } else if(event.info.code=="NetStream.Publish.BadName") {
               //someone's already on that stream name
            }
        }
        private function log(str:String):void {
            //ExternalInterface.call("console.log", str);
        }
    }
}