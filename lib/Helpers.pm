package Helpers;

use base 'Exporter';
our @EXPORT = qw(prompt_with);

sub prompt_with {
	my $text = shift;
	print $text;
	chomp (my $response = <STDIN>);
	return $response
}

1
