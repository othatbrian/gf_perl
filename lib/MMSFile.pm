package MMSFile;

use strict;
use warnings;

use FileHandle;
use MMSRecord;

##
## Public class methods
##
sub Load {
	my $caller = shift;
	my $filename = shift;
	my $file = new FileHandle;
	$file->open($filename) or die;
	my $uwi;
	my $last_uwi = 0;
	my $text = "";
	my %records;
	while(<$file>) {
		($uwi =  substr($_, 0, 12) . "00") =~ s/\s+//;
		if ($uwi == $last_uwi) {
			$text .= $_
		} else {
			$records{$last_uwi} = MMSRecord->new($text);
			$text = $_
		}
		$last_uwi = $uwi
	}
	$records{$last_uwi} = MMSRecord->new($text) if $text;
	bless \%records, $caller || ref $caller
}

## Public instance methods
sub findByUwi {
	my $self = shift;
	my $uwi = shift;
	return $self->{$uwi}
}

1
