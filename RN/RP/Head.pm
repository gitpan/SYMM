package Head;

BEGIN{ unshift @INC, '/usr/lib/perl5/SYMM/'; }

$VERSION = "0.5";

use Carp;
use XMLBase;
use XMLTag;
@ISA = qw( XMLTag );

my $head = "head";

sub init {
    my $self = shift;
    $self->SUPER::init( "head" );
    my %hash = @_;
}


1;
