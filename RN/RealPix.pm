package RealPix;

#BEGIN{ unshift @INC, '/usr/lib/perl5/SYMM/'; }

$VERSION = "0.5";

use Carp;
use SYMM::XMLBase;
use SYMM::XMLContainer;
use SYMM::XMLTag;
use SYMM::RN::RP::Head;
use SYMM::RN::RP::Image;
use SYMM::RN::RP::Fadein;
#use SYMM::RN::RP::Fadeout;
#use SYMM::RN::RP::Wipe;
use SYMM::RN::RP::Viewchange;
#use SYMM::RN::RP::Fill;
#use SYMM::RN::RP::Crossfade;

@ISA = qw( XMLContainer );

my %img_hash = ();
my $img_index = 1;
my %effects_hash = ();
my $effects_index = 1000;

my $imfl = "imfl";
my $head = "head";

sub init {
    my $self = shift;
    $self->SUPER::init( "imfl" );

    my %hash = @_;

    $self->initHead( @_ );
}

sub initHead {
    my $self = shift;
    my %hash = @_;
    $self->setTagContents( $head => new RP::Head( @_ ) )
	if( ( $hash{ 'height' } && $hash{ 'width' } ) ||
	    $hash{ 'meta' } );
}

sub addImage {
    my $self = shift;
    my $next = @_[ 0 ];
    
    if( ref( $next ) =~ /Image/ ) {
	$self->setTagContents( $img_index++ => $next );
    }
    else {
	$self->setTagContents( $img_index++ => new RP::Image( @_ ) );
    }
}

sub addEffect {

}

sub header {
    return "Content-type: text/x-pn-realpix\n\n";
}


1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

RealPix.pm - Perl extension for dynamic generation of RealPix files

=head1 SYNOPSIS

  use SYMM::RN::RealPix;

=head1 DESCRIPTION

This module provides an object oriented interface to generation of 
RealPix files, a datatype which plays within the RealPlayer from 
RealNetworks since version 6.0 (G2)
    
 use SYMM::RN::RealPix;
 $s = new RealPix;
 $s->addImage( src => "img.gif", handle => "hdl1" );
 $s->addEffect( type => "wipe", start => "3s", 
		src => "0,0,23,45", dst => "34,45,23,46" );

=head1 AUTHOR

Chris Dawson (cdawson@real.com, cdawson@bytravelers.com)

=head1 SEE ALSO

perl(1). perldoc CGI

=cut
