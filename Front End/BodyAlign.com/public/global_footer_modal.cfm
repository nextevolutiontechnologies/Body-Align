<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script> 
<script src="/global/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/global/js/bootstrapValidator-0.5.3.min.js"></script>
      <script type="text/javascript">
      
    $(document).ready(function() {
  $('#modal-fullscreen').on('hidden.bs.modal', function() {
    var $this = $(this).find('iframe'),
      tempSrc = $this.attr('src');
    $this.attr('src', "");
    $this.attr('src', tempSrc);
  });

  $('#html5Video').on('hidden.bs.modal', function() {
    var html5Video = document.getElementById("htmlVideo");
    if (html5Video != null) {
      html5Video.pause();
      html5Video.currentTime = 0;
    }
  });
});
</script>
       
  
  <script>
$('#idj-play-button').click(function () {
    document.getElementById('peaks-audio').play();
    $('#idj-play-button').addClass('hide');
    $('#idj-pause-button').removeClass('hide');

});

$('#idj-pause-button').click(function () {
    document.getElementById('peaks-audio').pause();
    $('#idj-pause-button').addClass('hide');
    $('#idj-play-button').removeClass('hide');
});

$('#peaks-audio').on('ended', function() {
  $('#idj-pause-button').addClass('hide');
  $('#idj-play-button').removeClass('hide');
  $('#peaks-audio').load();
});

 
</script>

<script>
$('#idj2-play-button').click(function () {
    document.getElementById('peaks-audio2').play();
    $('#idj2-play-button').addClass('hide');
    $('#idj2-pause-button').removeClass('hide');

});

$('#idj2-pause-button').click(function () {
    document.getElementById('peaks-audio2').pause();
    $('#idj2-pause-button').addClass('hide');
    $('#idj2-play-button').removeClass('hide');
});

$('#peaks-audio2').on('ended', function() {
  $('#idj2-pause-button').addClass('hide');
  $('#idj2-play-button').removeClass('hide');
  $('#peaks-audio2').load();
});

</script>

<script>
// .modal-backdrop classes

$(".modal-transparent").on('show.bs.modal', function () {
  setTimeout( function() {
    $(".modal-backdrop").addClass("modal-backdrop-transparent");
  }, 0);
});
$(".modal-transparent").on('hidden.bs.modal', function () {
  $(".modal-backdrop").addClass("modal-backdrop-transparent");
});

$(".modal-fullscreen").on('show.bs.modal', function () {
  setTimeout( function() {
    $(".modal-backdrop").addClass("modal-backdrop-fullscreen");
  }, 0);
});
$(".modal-fullscreen").on('hidden.bs.modal', function () {
  $(".modal-backdrop").addClass("modal-backdrop-fullscreen");
});

</script>
<script type="text/javascript">
jQuery(function(){var $slider=jQuery('.slider'),transitionTime=15000;$slider.width(280).find('.slide').not('.current').fadeOut(0);setInterval(function(){$slider.find('.current').removeClass('current').fadeOut(500,function(){var $this=jQuery(this);if($this.is(':last-child')){var $nextItem=$slider.find('.slide:first-child');}else{var $nextItem=$this.next();}
$nextItem.addClass('current').fadeIn(500);});},transitionTime);});
</script> 
 
 
 </body>
</html>
