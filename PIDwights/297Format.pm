package PIDwights::297Format;

use strict;
use warnings;

use PIDwights;
@PIDwights::297Format::ISA = ("PIDwights");

##
## Public instance methods
##
sub getElevation {
	my $self = shift;
	return $self->{"elevation"} if exists $self->{"elevation"};
	$self->{"string"} =~ /^A.{57}(.{5})/m;
	($self->{"elevation"} = $1) =~ s/\s+//;
	return $self->{"elevation"}
}

sub getFinalWellClass {
	my $self = shift;
	return $self->{"final_well_class"} if exists $self->{"final_well_class"};
	$self->{"string"} =~ /^A.{50}(.)/m;
	$self->{"final_well_class"} = $1;
	return $self->{"final_well_class"}
}

sub getLatitude {
	my $self = shift;
	return $self->{"latitude"} if exists $self->{"latitude"};
	$self->{"string"} =~ /^A.{14}(.{9})/m;
	($self->{"latitude"} = $1) =~ s/\s+//;
	return $self->{"latitude"}
}

sub getLeaseName {
	my $self = shift;
	return $self->{"lease_name"} if exists $self->{"lease_name"};
	$self->{"string"} =~ /^C.{23}(.{19})/m;
	($self->{"lease_name"} = $1) =~ s/\s+$//;
	return $self->{"lease_name"}
}

sub getLongitude {
	my $self = shift;
	return $self->{"longitude"} if exists $self->{"longitude"};
	$self->{"string"} =~ /^A.{23}(.{10})/m;
	($self->{"longitude"} = $1) =~ s/\s+//;
	return $self->{"longitude"}
}

sub getMeasuredDepth {
	my $self = shift;
	return $self->{"measured_depth"} if exists $self->{"measured_depth"};
	$self->{"string"} =~ /^A.{64}(.{5})/m;
	$self->{"measured_depth"} = $1;
	$self->{"measured_depth"} =~ s/\s+// if $self->{"measured_depth"};
	return $self->{"measured_depth"}
}

sub getOperator {
	my $self = shift;
	return $self->{"operator"} if exists $self->{"operator"};
	$self->{"string"} =~ /^C(.{23})/m;
	($self->{"operator"} = $1) =~ s/\s+$//;
	return $self->{"operator"}
}

sub getSpudDate {
	my $self = shift;
	return $self->{"spud_date"} if exists $self->{"spud_date"};
	$self->{"string"} =~ /^DA.{68}(.{8})/m;
	($self->{"spud_date"} = $1) =~ s/\s+//;
	return $self->{"spud_date"}
}

sub getUwi {
	my $self = shift;
	return $self->{"uwi"} if exists $self->{"uwi"};
	$self->{"string"} =~ /^A(\d{14})/m;
	$self->{"uwi"} = $1;
	return $self->{"uwi"}
}

sub getWellName {
	my $self = shift;
	return $self->{"well_name"} if exists $self->{"well_name"};
	$self->{"well_name"} = $self->getLeaseName . "_" . $self->getWellNumber;
	$self->{"well_name"} =~ s/\s/_/g;
	return $self->{"well_name"}
}

sub getWellNumber {
	my $self = shift;
	return $self->{"well_number"} if exists $self->{"well_number"};
	$self->{"string"} =~ /^C.{42}(.{10})/m;
	($self->{"well_number"} = $1) =~ s/\s+$//;
	return $self->{"well_number"}
}

1