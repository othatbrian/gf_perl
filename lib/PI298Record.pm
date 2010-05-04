package PI298Record;

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

sub getPerforation {
	my $self = shift;
	return $self->{"perfs"} if exists $self->{"perfs"};
	$self->{"string"} =~ /^\+D\!.{48}(.{5})(.{5})/m or return;
	my ($upper, $lower) = ($1, $2);
	$upper =~ s/\s+//;
	$lower =~ s/\s+//;
	$self->{"perforation"} = [$upper, $lower]
}

sub getUwi {
	my $self = shift;
	return $self->{"uwi"} if exists $self->{"uwi"};
	$self->{"string"} =~ /^\+D (.{15})/m;
	return unless $1;
	($self->{"uwi"} = $1) =~ s/\s+//;
	return $self->{"uwi"}
}

1
