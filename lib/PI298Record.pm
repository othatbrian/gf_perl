package PI298Record;

use strict;
use warnings;

##
## Public instance methods
##
sub api {
	my $self = shift;
	return $self->{"api"} if exists $self->{"api"};
	$self->{"string"} =~ /^\+D (\d{14})/m;
	$self->{"api"} = $1;
	return $self->{"api"}
}

sub new {
	my $caller = shift;
	my $self = {"string" => shift};
	bless $self, ref $caller || $caller
}

1
