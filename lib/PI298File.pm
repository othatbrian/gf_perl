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
		## START_US_PROD means we're starting a new record
		if (/^START_US_PROD\s+.*$/) {
			print STDERR "Starting record\n";
			$text = ""
		## END_US_PROD means we've collected a record, so return it
		} elsif (/^END_US_PROD\s+.*$/) {
			print STDERR "Ending record\n";
			return PI298Record->new($text)
		## Otherwise we're still collecting a record
		} else {
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
