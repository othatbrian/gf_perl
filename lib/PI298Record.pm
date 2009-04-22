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

sub cumulative_production {
	my $self = shift;
	return $self->{"cumulative_production"} if exists $self->{"cumulative_production"};
	my @stats;
	my ($year, $liquid, $gas);
	for (split /\n/, $self->{"string"}) {
		/^\+F (\d{4})\s*?(\d{1,20})\s*?(\d{1,20})/;
		$year = $1;
		if ($year) {
			$liquid = $2 ? $2 : ($2 == 0 ? $2 : '');
			$gas = $3 ? $3 : ($3 == 0 ? $3 : '');
			@{$self->{"cumulative_production"}} = ($year, $liquid, $gas)
		}
	}
	@{$self->{"cumulative_production"}} = ('', '', '') unless defined $self->{"cumulative_production"};
	return $self->{"cumulative_production"}
}

sub new {
	my $caller = shift;
	my $self = {"string" => shift};
	bless $self, ref $caller || $caller
}

1
