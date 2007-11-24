package PIDwights;

use strict;
use warnings;

##
## Public instance methods
##
sub new {
	my $caller = shift;
	my $self = {"string" => shift};
	bless $self, ref $caller || $caller
}

1