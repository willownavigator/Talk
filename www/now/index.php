<!DOCTYPE html 
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Talking</title>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-language" content="en" />
</head>
<body>
  <h1>Talking</h1>
  <div id="me"></div>
  
  <script type="text/javascript" src="/static/deps/swfobject.js"></script>
  <script type="text/javascript">
  var flashvars = {
      who: '<?php echo @$_GET["who"]=="me" ? "me" : "you"; ?>',
      rtmp: 'rtmp://talk.mokele.co.uk:1935/talk'
  };
  var params = {};
  var attributes = {};
  swfobject.embedSWF("/static/talk.swf", "me", "480", "360", "9.0.0","expressInstall.swf", flashvars, params, attributes);
  </script>
  
</body>
</html>
