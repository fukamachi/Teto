package Teto::Track::YouTube;
use Mouse;
use WWW::YouTube::Download;

extends 'Teto::Track';

has video_id => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has youtube_client => (
    is  => 'rw',
    isa => 'WWW::YouTube::Download',
    default => sub { WWW::YouTube::Download->new },
);

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    $url =~ m<^http://www\.youtube\.com/watch\?.*?\bv=([^&]+)> or return undef;
    return { video_id => $1 };
};

override play => sub {
    my $self = shift;
    my $video_url = eval { $self->youtube_client->get_video_url($self->video_id) } or do {
        $self->error("get_video_url failed: $@");
        return;
    };
    my $fh = $self->url_to_fh($video_url);
    $self->ffmpeg($fh);
};

__PACKAGE__->meta->make_immutable;

no Mouse;

1;