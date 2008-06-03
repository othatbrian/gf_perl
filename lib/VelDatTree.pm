package VelDatTree;

use strict;
use warnings;

use FileHandle;

##
## Public instance methods
##

sub new {
	return bless {}, shift;
}

sub parse {
	my $self = shift;
	my $dir = shift;		
	$self->_descend($dir)
}

sub getCheckshotByUwi {
	my $self = shift;
	my $uwi = shift;
	return "" unless $self->{$uwi};
	my $options = shift;
	$options->{"name"} = "VelDat" unless $options->{"name"};
	my $text = join("\t", $uwi, "0", "0", $options->{"name"}, "\n");
	for (@{$self->{$uwi}}) {
		$text .= join("\t", $uwi, $_, $options->{"name"}, "\n")
	}
	return $text
}

##
## Private instance methods
##

sub _descend {
	my $self = shift;
	my $dir = shift;
	opendir(DIR, $dir);
	my @files = readdir(DIR);
	closedir(DIR);
	
	for $_ (@files) {
		next if ($_ eq "." || $_ eq ".." || $_ eq ".snapshot");
		$self->_descend("$dir/$_") if (-d "$dir/$_");
		if (-f "$dir/$_") {
			my $file = new FileHandle;
			$file->open("$dir/$_") or die;
			my $uwi;
			while (<$file>) {
				s/\r//;
				chomp;
				if ($_ =~ /A (\d{14})/) { $uwi = $1 }
				if ($_ =~ /E\t(\S*)\t(\S*)/) { push @{$self->{$uwi}}, "$1\t$2"}
			}
		}
	}
}

1