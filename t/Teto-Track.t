use strict;
use Test::More tests => 7;
use Test::Deep;
use Teto::Buffer;

use_ok 'Teto::Track';

my $track = new_ok 'Teto::Track', [ url => '' ];

my $buf = Teto::Buffer->new;
$track->buffer($buf);
$track->write('xxx');
is $buf->buffer, 'xxx';

cmp_set [ Teto::Track->subclasses ], [
    qw(Teto::Track::NicoVideo::sm Teto::Track::NicoVideo::nm Teto::Track::YouTube)
], 'subclasses';

subtest nicovideo_sm => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/sm11809611');
    isa_ok $track, 'Teto::Track::NicoVideo::sm';
};

subtest nicovideo_nm => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/nm3254039');
    isa_ok $track, 'Teto::Track::NicoVideo::nm';
};

subtest 'none handles' => sub {
    my $track = Teto::Track->from_url('http://www.example.com/');
    ok not $track;
};
