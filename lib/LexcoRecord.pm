package LexcoRecord;

use strict;
use warnings;

use Math::Trig;

use constant PI => 4*atan2(1,1);
use constant FT_PER_M => 3.280840;
use constant M_PER_SEC_LAT => 30.82;
use constant MAJOR_AXIS => 6378206;
use constant MINOR_AXIS => 6356583;

##
## Public instance methods
##
sub getBlockName {
	my $self = shift;
	return $self->{"block_name"} if exists $self->{"block_name"};
	$self->{"block_name"} = substr($self->{"string"}, 360, 9);
	$self->{"block_name"} =~ s/\s+//;
	return $self->{"block_name"}
}

sub getBottomLatitude {
	my $self = shift;
	return $self->{"bottom_latitude"} if exists $self->{"bottom_latitude"};
	$self->{"bottom_latitude"} = substr($self->{"string"}, 302, 10);
	$self->{"bottom_latitude"} =~ s/^\s+//;
	return $self->{"bottom_latitude"}
}

sub getBottomLongitude {
	my $self = shift;
	return $self->{"bottom_longitude"} if exists $self->{"bottom_longitude"};
	$self->{"bottom_longitude"} = substr($self->{"string"}, 291, 10);
	$self->{"bottom_longitude"} =~ s/^\s+//;
	return $self->{"bottom_longitude"}
}

sub getElevation {
	my $self = shift;
	return $self->{"elevation"} if exists $self->{"elevation"};
	$self->{"elevation"} = substr($self->{"string"}, 102, 10);
	$self->{"elevation"} =~ s/^\s+//;
	return $self->{"elevation"}
}

sub getFinalWellClass {
	my $self = shift;
	return $self->{"final_well_class"} if exists $self->{"final_well_class"};
	$self->{"final_well_class"} = substr($self->{"string"}, 313, 3);
	$self->{"final_well_class"} =~ s/\s+$//;
	return $self->{"final_well_class"}
}

sub getLatitude {
	my $self = shift;
	return $self->{"latitude"} if exists $self->{"latitude"};
	$self->{"latitude"} = substr($self->{"string"}, 280, 10);
	$self->{"latitude"} =~ s/^\s+//;
	return $self->{"latitude"}
}

sub getLeaseName {
	my $self = shift;
	return $self->{"lease_name"} if exists $self->{"lease_name"};
	$self->{"lease_name"} = substr($self->{"string"}, 26, 7);
	$self->{"lease_name"} =~ s/\s+//;
	return $self->{"lease_name"}
}

sub getLongitude {
	my $self = shift;
	return $self->{"longitude"} if exists $self->{"longitude"};
	$self->{"longitude"} = substr($self->{"string"}, 269, 10);
	$self->{"longitude"} =~ s/^\s+//;
	return $self->{"longitude"}
}

sub getMeasuredDepth {
	my $self = shift;
	return $self->{"measured_depth"} if exists $self->{"measured_depth"};
	$self->{"measured_depth"} = substr($self->{"string"}, 113, 10);
	$self->{"measured_depth"} =~ s/^\s+// if $self->{"measured_depth"};
	return $self->{"measured_depth"}
}

sub getOperator {
	my $self = shift;
	return $self->{"operator"} if exists $self->{"operator"};
	$self->{"operator"} = substr($self->{"string"}, 226, 30);
	$self->{"operator"} =~ s/\s+$//;
	return $self->{"operator"}
}

sub getSpudDate {
	my $self = shift;
	return $self->{"spud_date"} if exists $self->{"spud_date"};
	$self->{"spud_date"} = substr($self->{"string"}, 51, 10);
	$self->{"spud_date"} =~ s/\s+$// if $self->{"spud_date"};
	return $self->{"spud_date"}
}

sub getTwoPointDirectionalSurvey {
	my $self = shift;
	my $lat_top = $self->getLatitude;
	my $long_top = $self->getLongitude;
	my $lat_bot = $self->getBottomLatitude;
	my $long_bot = $self->getBottomLongitude;
	return $self->{"two_point_directional_survey"} if exists $self->{"two_point_directional_survey"};
	return undef unless ($lat_bot && $long_bot);
	return undef if ($lat_bot == $lat_top and $long_bot == $long_top);
	my $feet_per_deg_lat = M_PER_SEC_LAT*3600*FT_PER_M;
	my $feet_per_deg_long = FT_PER_M*PI/180*(cos($lat_top*PI/180))*(sqrt(((MAJOR_AXIS**4)*(cos($lat_top*PI/180)**2)+(MINOR_AXIS**4)*(sin($lat_top*PI/180)**2))/(((MAJOR_AXIS*(cos($lat_top*PI/180)))**2)+((MINOR_AXIS*(sin($lat_top*PI/180)))**2))));
	my $text = $self->getUwi . ", 0, 0, 0\n";
	$text .= join ", ", $self->getUwi, $self->getMeasuredDepth, ($long_bot-$long_top)*$feet_per_deg_long, ($lat_bot-$lat_top)*$feet_per_deg_lat;
	return $text . "\n"
}

sub getUwi {
	my $self = shift;
	return $self->{"uwi"} if exists $self->{"uwi"};
	$self->{"uwi"} = substr($self->{"string"}, 380, 12);
	$self->{"uwi"} .= "00";
	$self->{"uwi"} = undef unless $self->{"uwi"} =~ m/[\d]{14}/;
	return $self->{"uwi"}
}

sub getWellName {
	my $self = shift;
	return $self->{"well_name"} if exists $self->{"well_name"};
	$self->{"well_name"} = substr($self->{"string"}, 393, 16);
	$self->{"well_name"} =~ s/\s+$//;
	return $self->{"well_name"}
}

sub getWellNumber {
	my $self = shift;
	return $self->{"well_number"} if exists $self->{"well_number"};
	$self->{"well_number"} = substr($self->{"string"}, 410, 6);
	$self->{"well_number"} =~ s/\s+//;
	return $self->{"well_number"}
}

sub new {
	my $caller = shift;
	my $self = {"string" => shift};
	bless $self, ref $caller || $caller
}

1
