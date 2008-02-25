package MMSRecord;

use strict;
use warnings;

##
## Public instance methods
##
sub getDirectionalSurvey {
	my $self = shift;
	return $self->{"directional_survey"} if exists $self->{"directional_survey"};
	my $uwi;
	for (split /\n/, $self->{"string"}) {
		@_ =  split /\s+/, $_;
		$uwi = $_[0] . "00" if length($_[0]) == 12;
		my $dev = $_[1] + $_[2] / 60;
		chop(my $md = $_[3]);
		my $ns = chop $_[3];
		my $az = $_[4];
		my $ew = chop $_[5];
	
		if ($ns eq "N") {
			$az = $ew eq "E" ? $az : 360 - $az
		} else {
			$az = $ew eq "E" ? 180 - $az : 180 + $az
		}
	
		$self->{"directional_survey"} .= "$uwi, $md, $dev, $az\n"
	}
	$self->{"directional_survey"} = "$uwi, 0, 0, 0\n" . $self->{"directional_survey"} if $self->{"directional_survey"};
	
	return $self->{"directional_survey"}
}

sub new {
	my $caller = shift;
	my $string = shift;
	my $self = {"string" => $string};
	bless $self, ref $caller || $caller
}

1
