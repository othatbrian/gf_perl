package VelDatRecord;

use strict;
use warnings;

##
## Public instance methods
##
sub getCheckshot {
	my $self = shift;
	my $text = $self->getUwi . "\t0\t0\tVelDat\n";
	for (43...92) {
		if ($self->[$_] && $self->[$_ + 50]) {
			$text .= $self->getUwi . "\t$self->[$_]\t$self->[$_ + 50]\tVelDat\n"
		} else {
			last
		}
	}
	return $text
}

sub getUwi {
	my $self = shift;
	return $self->[5];
}

sub new {
	my $caller = shift;
	my @self = split /,/, shift;
	bless \@self, ref $caller || $caller
}

1
