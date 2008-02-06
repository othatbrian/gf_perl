package VelDatFile;

use strict;
use warnings;

use FileHandle;
use VelDatRecord;

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
		if (/,$/ or /,\d+$/) {
			## A , followed by a line ending or a , followed only by
			## numbers and a line ending indicates a complete record
			return VelDatRecord->new($text . $_)
		} else {
			## Otherwise we're still collecting a record
			$text .= $_
		}
	}
}

sub read {
	my $caller = shift;
	my $file = new FileHandle;
	$file->open(shift) or die;
	my $self = {"file" => $file};
	bless $self, ref $caller || $caller
}

1
