package SYMM::SMIL::RootLayout;

$VERSION = "0.5";

use SYMM::SMIL::XMLTag;

@ISA = qw( SYMM::SMIL::XMLTag );

sub init {
    my $self = shift;
    $self->SUPER::init( "root-layout" );
}
