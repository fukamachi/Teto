? local %_ = @_;
? my $control = $_{control};
<!DOCTYPE html>
<html>
  <head>
    <title>Teto</title>
    <link rel="stylesheet" href="/css/style.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
    <script type="text/javascript">
var Teto = {};
Teto.feederURL = null;
Teto.selectFeeder = function (url) {
  $.get('/api/feeder', { url: url }).success(
    function (html) {
    Teto.feederURL = url;
    $('#feeder').html(html);
      $('#select-feeder li').each(function () {
        $(this).attr('data-feeder-url') == url ? $(this).addClass('selected') : $(this).removeClass('selected');
      });
    }
  );
};
Teto.selectTrack = function (index) {
  $.post('/api/track', { feeder: Teto.feederURL, index: index }).success(
    function (html) {
      $('#feeder').html(html);
    }
  );
};
Teto.addNewFeeder = function () {
  var url = prompt('Enter playlist URL', '');
  if (url) {
    $.post('/api/feeder', { url: url });
  }
};
$(function () {
  $('#select-feeder li').live('click', function () {
    if (this.id == 'add-new-feeder') {
      Teto.addNewFeeder();
    } else {
      Teto.selectFeeder($(this).attr('data-feeder-url'));
    }
  }).live('keypress', function (e) { if (e.keyCode == 13) $(this).click() });

  $('#feeder li.track').live('click', function (e) {
    if (e.target == this) Teto.selectTrack($(this).attr('data-track-index'));
  }).live('keypress', function (e) {
    if (e.target == this && e.keyCode == 13) Teto.selectTrack($(this).attr('data-track-index'));
    });
});

$(function () {
  $('#queue .track span.delete').live('click', function () {
    $.post('/api/delete_track', { i: $(this).parent('li.track').attr('data-track-index') });
  });
});
    </script>
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream</a></h1>

    <section id="queue" class="queue">
      <h1>Queue</h1>
      <ul>
? for (0 .. $#{ $control->queue->tracks }) {
?   my $track = $control->queue->tracks->[$_];
?   my $current_track_url = $control->queue->current_track && $control->queue->current_track->url || '';
  <li class="track <?= $_ % 2 ? 'odd' : 'even' ?> <? if ($track->is_system) { ?>system<? } ?> <? if ($track->url eq $current_track_url) { ?>playing<? } ?>" data-track-index="<?= $_ ?>" tabindex="0">
?   if ($track->is_system) {
      <span class="title"><?= $track->title ?></span>
?   } else {
?     if (0 && $track->image) {
      <img src="<?= $track->image ?>">
?     }
?     if (defined $track->title) {
      <span class="title"><?= $track->title ?></span>
?     } else {
      <span class="title not-loaded">(not loaded)</span>
?     }
?   }
    <span class="button delete" tabindex="0">×</span>
  </li>
? }
      </ul>
    </section>

    <nav>
      <ul id="select-feeder">
? my $feeder_url = $control->feeder && $control->feeder->url || '';
? for my $feeder (values %{ Teto->feeders }) {
        <li class="<? if ($feeder->url eq $feeder_url) { ?>selected<? } ?>" tabindex="0" data-feeder-url="<?= $feeder->url ?>"><? if ($feeder->image) { ?><span class="icon-container"><img src="<?= $feeder->image ?>"></span> <? } ?><?= $feeder->title || $feeder->url ?></li>
? }
        <li id="add-new-feeder" tabindex="0">&nbsp;+&nbsp;</li>
      </ul>
    </nav>

    <section id="feeder" class="feeder">
? if (my $feeder = $control->feeder) {
?=  $_mt->render_file('_feeder.mt', $feeder, $control);
? }
    </section>

    </div>
  </body>
</html>
