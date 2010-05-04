package PI298File;

use strict;
use warnings;

use FileHandle;
use PI298Record;

##
## Public instance methods
##
sub nextRecord {
	my $self = shift;
	my $file = $self->{"file"};
	my $text = "";
	while(<$file>) {
		## Remove any line endings
		s/\r//;
		chomp;
		if (/^START_US_PROD\s+\d+$/) {
			## START_US_WELL means we're starting a new record
			$text = ""
		} elsif (/^END_US_PROD\s+\d+$/) {
			## END_US_WELL means we've collected a record, so return it
			return PI298Record->new($text)
		} else {
			## Otherwise we're still collecting a record
			$text .= "\n$_"
		}
	}
}

sub read {
	my $caller = shift;
	my $filename = shift;
	my $file = new FileHandle;
	$file->open($filename) or die "Could not open file \"$filename\"!\n";
	my $self = {"file" => $file};
	bless $self, ref $caller || $caller
}

1
