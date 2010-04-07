var params = { allowScriptAccess: "always" };
var atts = { id: "myytplayer" };
var currentVideoIndex = 0;

function embedVideo(video) {
  log('Loading video: '+video.name);
  $$('h1').each(function(e) { e.update(video.name); })
  $('video-info').update( "big ups to <span class='user'>"+video.user+"</span><br /><a href='"+video.comments_url+"'>comments</a>" );
  resetContainer();
  swfobject.embedSWF( "http://www.youtube.com/v/"+video.video_id+"?enablejsapi=1&playerapiid=ytplayer", "ytapiplayer", "425", "356", "8", null, null, params, atts );
}

function resetContainer() {
  if($('ytapiplayer')!=null) $('ytapiplayer').remove();
  $('player-container').update("<div id='ytapiplayer'>You need Flash player 8+ and JavaScript enabled to view this video.</div>");
}

function log(string) { if(console!=null) console.log(' -> '+string.toString()); }

document.observe("dom:loaded", function() {
  if(playlist!=null) {
    log('Loaded! Playlist is ready! Starting playback...')
    embedVideo(playlist.first());
  }
});

function onYouTubePlayerReady(playerId) {
  ytplayer = document.getElementById("myytplayer");
  ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
  ytplayer.playVideo();
}

function nextVideo() {
  currentVideoIndex++;
  var nextVideo = playlist[currentVideoIndex];
  if(nextVideo==null) {
    alert('Out of content :(')
  } else {
    embedVideo(nextVideo);
  }
}

function onytplayerStateChange(newState) {
  if(newState==0) {
    log('Video has finished playing!')
    nextVideo();
  }
}
