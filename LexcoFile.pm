package LexcoFile;

use strict;
use warnings;

use FileHandle;
use LexcoRecord;

##
## Public instance methods
##
sub nextRecord {
	my $self = shift;
	my $file = $self->{"file"};
	while(<$file>) {
		my $record = LexcoRecord->new($_);
		return $record if $record->getUwi
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
