package PI297Record;

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
sub getDirectionalSurveyWithDevAz {
	my $self = shift;
	return $self->{"directional_survey_devaz"} if exists $self->{"directional_survey_devaz"};
	my $text = "";
	my ($md, $dev, $az);
	for (split "\n", $self->{"string"}) {
		next unless /^U2...(.{5}).{8}(.{6})(.{6})/;
		($md, $dev, $az) = ($1, $2, $3);
		map {$_ =~ s/\s+//} $md, $dev, $az;
		next unless $dev && $az;
		$text .= $self->getUwi . ", 0, 0, 0\n" if ($text eq "" and $md != 0);
		$text .= $self->getUwi . ", $md, $dev, $az\n"
	}
	$self->{"directional_survey_devaz"} = $text;
	return $text
}

sub getDirectionalSurveyWithDxDy {
	my $self = shift;
	return $self->{"directional_survey_dxdy"} if exists $self->{"directional_survey_dxdy"};
	my $text = "";
	my ($md, $dx, $dy);
	for (split "\n", $self->{"string"}) {
		next unless /^U2...(.{5}).{20}(.{9})(.{9})/;
		($md, $dy, $dx) = ($1, $2, $3);
		map {$_ =~ s/\s+//} $md, $dx, $dy;
		if (chop($dx) eq "W") {
			$dx = sprintf("%.2f", 0.0 - $dx)
		}
		if (chop($dy) eq "S") {
			$dy = sprintf("%.2f", 0.0 - $dy)
		}
		$text .= $self->getUwi . ", 0, 0, 0\n" if ($text eq "" and $md != 0);
		$text .= $self->getUwi . ", $md, $dx, $dy\n"
	}
	$self->{"directional_survey_dxdy"} = $text;
	return $text
}

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
	($self->{"spud_date"} = $1) =~ s/\s+// if $1;
	return $self->{"spud_date"}
}

sub getTwoPointDirectionalSurvey {
	my $self = shift;
	return $self->{"two_point_directional_survey"} if exists $self->{"two_point_directional_survey"};
	$self->{"string"} =~ /^DA(.{9})(.{10})/m;
	my ($lat_bot, $long_bot) = ($1, $2);
	my ($lat_top, $long_top) = ($self->getLatitude, $self->getLongitude);
	map {s/\s+//} $lat_bot, $long_bot;
	return "" unless ($lat_bot && $long_bot);
	my $feet_per_deg_lat = M_PER_SEC_LAT*3600*FT_PER_M;
	my $feet_per_deg_long = FT_PER_M*PI/180*(cos($lat_top*PI/180))*(sqrt(((MAJOR_AXIS**4)*(cos($lat_top*PI/180)**2)+(MINOR_AXIS**4)*(sin($lat_top*PI/180)**2))/(((MAJOR_AXIS*(cos($lat_top*PI/180)))**2)+((MINOR_AXIS*(sin($lat_top*PI/180)))**2))));
	my $text = $self->getUwi . ", 0, 0, 0\n";
	$text .= join ", ", $self->getUwi, $self->getMeasuredDepth, ($long_bot-$long_top)*$feet_per_deg_long, ($lat_bot-$lat_top)*$feet_per_deg_lat;
	return $text . "\n"
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

sub new {
	my $caller = shift;
	my $self = {"string" => shift};
	bless $self, ref $caller || $caller
}

1
