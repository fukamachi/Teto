package Teto::Server::Queue::Entry;
use Any::Moose;
use overload
        '""' => 'stringify',
        fallback => 1;

has 'url', (
    is  => 'rw',
    isa => 'Str',
);

has 'code', (
    is  => 'rw',
    isa => 'CodeRef',
);

has 'name', (
    is  => 'rw',
    isa => 'Str',
);

has 'icon_url', (
    is  => 'rw',
    isa => 'Str',
);

around BUILDARGS => sub {
    my ($orig, $class, @args) = @_;
    if (@args == 1) {
        my $arg = $args[0];
        if (ref $arg eq 'CODE') {
            @args = ( code => $arg );
        } elsif (!ref $arg) {
            @args = ( url  => $arg );
        }
    }
    return $orig->($class, @args);
};

__PACKAGE__->meta->make_immutable;

sub as_html {
    my $self = shift;
    if ($self->url) {
        qq#<img src="$self->{icon_url}" width="16" height="16" /><a href="$self->{url}">$self->{name}</a>#;
    } else {
        qq#<img src="$self->{icon_url}" width="16" height="16" />$self->{name}#;
    }
}

sub stringify {
    my $self = shift;

    my $string = '(null)';
    if ($self->url) {
        $string = "<$self->{url}>";
    } elsif ($self->code) {
        $string = '#CODE';
    }

    if ($self->name) {
        $string = $self->name . ' ' . $string;
    }

    return $string;
}

1;