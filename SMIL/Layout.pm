package SYMM::SMIL::Layout;

my $debug = 1;

$VERSION = "0.5";

use SYMM::SMIL::XMLContainer;
use SYMM::SMIL::RootLayout;
use SYMM::SMIL::Region;
use SYMM::SMIL::SystemSwitches;

@ISA = qw( SYMM::SMIL::XMLContainer );

use Carp;

my $switch_target = "switch-target";
my @rootLayoutAttributes = ( 'height', 'width', 'background-color' );
my @layoutAttributes = @systemSwitchAttributes;

my $root_layout = "root-layout";

sub init {
    my $self = shift;
    $self->SUPER::init( "layout" );
    my %hash = @_;

    if( $hash{ $switch_target } ) {
	$self->setAttributes( $hash{ $switch_target } => 
			      $hash{ $hash{ $switch_target } } );
    }

    my %layoutAttrs = $self->createValidAttributes( { %hash },
						    [ @layoutAttributes ] );

    $self->setAttributes( %layoutAttrs );

    # Grab height and width from the hash if we don't have root-layout
    my %rootLayoutAttrs;
    if( !$hash{ root_layout } ) {
	%rootLayoutAttrs = 
	    $self->createValidAttributes( { %hash },
					  [@rootLayoutAttributes] );
    }
    else {
	my $rl_hash = $hash{ root_layout };
	%rootLayoutAttrs = 
	    $self->createValidAttributes( { %$rl_hash }, 
					  [@rootLayoutAttributes] );
    }

    $self->{$root_layout} = new SYMM::SMIL::RootLayout;
    $self->{$root_layout}->setAttributes( %rootLayoutAttrs );
    $self->setTagContents( $root_layout => $self->{$root_layout} );
}

my $name = 'name';
my $id = "id";
my @regionAttributes = ( $id, 'top', 'left', 'height', 'width',
			'z-index', 'background-color' );

my $regions = "regions";


sub addRegion {
    my $self = shift;
    my %hash = @_;

    # Now, set up the new SYMM::SMIL::region

    # If they used "name" instead of "id" fix that
    $hash{ $id } = $hash{ $name } if $hash{ $name };

    my %attrs = $self->createValidAttributes( { %hash },  
					     [@regionAttributes] );
    $ZERO_STRING = "ZERO_STRING";
    my $region = new SYMM::SMIL::Region;
    $region->setAttributes( %attrs );
    $region->setAttribute( 'top' => $ZERO_STRING ) unless $hash{ 'top' };
    $region->setAttribute( 'left' => $ZERO_STRING ) unless $hash{ 'left' };
    
#    $hash{ 'top' } = '0' unless $hash{ 'top' };
#    $hash{ 'left' } = '0' unless $hash{ 'left' };

    my $current_regions = $self->getContentObjectByName( $regions );
    
    if( !( $current_regions && @$current_regions ) ) {
	$current_regions = [];
    }

    # If error checking is set to true, check to see if the new
    # region has the same name as a previously existing region
    if( $check_errors ) {
	foreach $reg ( @$current_regions ) {
	    croak "Region \"" . $attrs{ $id } . 
		"\" has the same name as another existing region"
		    if $attrs{ $id } && 
			$reg->getAttribute( $id ) eq $attrs{ $id };
	}
    }
    
    push @$current_regions, $region;
    $self->setTagContents( $regions => $current_regions );
}






