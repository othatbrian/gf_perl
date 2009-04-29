package GFProject;

use strict;
use DBI;

##
## Class variables
##
my $_dbh;

##
## Public class methods
##

sub END {
	$_dbh->disconnect if $_dbh
}

##
## Public instance methods
##

sub connect {
	my $caller = shift;
	my $self = {};
	$self->{"cache"} = {};
	my ($proj, $pass) = @_;
	my $dbh = _GetDbHandle($proj, $pass);
	bless $self, ref $caller || $caller
}

sub disconnect {
	my $self = shift;
	$_dbh->disconnect
}

sub getAllUwis {
	my $self = shift;
	return @{$self->{"cache"}->{"getAllUwis"}} if $self->{"cache"}->{"getAllUwis"};
	my $sql = "select uwi from borehole";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql)};
	@{$self->{"cache"}->{"getAllUwis"}} = sort {$b cmp $a} @_;
	return @{$self->{"cache"}->{"getAllUwis"}}
}

sub getCheckshotsByUwi {
	my $self = shift;
	my $sql = "select w.id from well_check_shot_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole' and b.uwi = ?";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {}, shift)};
	return @_
}

sub getDuplicateUwis {
	my $self = shift;
	return @{$self->{"cache"}->{"getDuplicateUwis"}} if $self->{"cache"}->{"getDuplicateUwis"};
	my @all = $self->getAllUwis;
	for (1 .. $#all) {
		if ($all[$_ - 1] =~ m/$all[$_]/) {
			push @_, $all[$_ - 1] unless $all[-1] eq $all[$_ - 1];
			push @_, $all[$_]
		}
	}
	@{$self->{"cache"}->{"getDuplicateUwis"}} = @_;
	return @{$self->{"cache"}->{"getDuplicateUwis"}}
}

sub getDeviationsByUwi {
	my $self = shift;
	my $sql = "select w.id from well_deviation_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole' and b.uwi = ?";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {}, shift)};
	return @_
}

sub getLogCurvesByUwi {
	my $self = shift;
	my $sql = "select l.id from log_curve l, borehole b where l.borehole_id = b.id and b.uwi = ?";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {}, shift)};
	return @_
}

sub getMarkersByUwi {
	my $self = shift;
	my $sql = "select distinct e.entity_id from e_to_rr e, borehole b where e.implementation_table in ('Biostrat_Marker','Chronostrat_Marker','Fault_Marker','Fluid_Marker','SedMarker','Strat_Marker','Struct_Marker','Struct_XSect_Marker','Well_Marker') and e.entity_table = 'Borehole' and e.property_order = 0 and e.entity_id = b.id and b.uwi = ?";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {}, shift)};
	return @_
}

sub getTwoPointsByUwi {
	my $self = shift;
	my $sql = "select w.id from well_deviation_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole' and b.uwi = ? and w.source = 'two_points'";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {}, shift)};
	return @_
}

sub getUwiCreationDate {
	my $self = shift;
	my $sql = "select create_date from borehole where uwi = ?";
	$_dbh->selectrow_arrayref($sql, {}, shift)->[0]
}

sub getUwisWithCheckshots {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithCheckshots"}} if $self->{"cache"}->{"getUwisWithCheckshots"};
	my $sql = "select distinct b.uwi from well_check_shot_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole'";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {})};
	@{$self->{"cache"}->{"getUwisWithCheckshots"}} = @_
}

sub getUwisWithDeviations {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithDeviations"}} if $self->{"cache"}->{"getUwisWithDeviations"};
	my $sql = "select distinct b.uwi from well_deviation_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole'";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {})};
	@{$self->{"cache"}->{"getUwisWithDeviations"}} = @_
}

sub getUwisWithRealDeviations {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithRealDeviations"}} if $self->{"cache"}->{"getUwisWithRealDeviations"};
	my $sql = "select distinct b.uwi from well_deviation_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole' and w.source != 'two_points'";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {})};
	@{$self->{"cache"}->{"getUwisWithRealDeviations"}} = @_
}

sub getUwisWithTwoPoints {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithTwoPoints"}} if $self->{"cache"}->{"getUwisWithTwoPoints"};
	my $sql = "select distinct b.uwi from well_deviation_survey w, borehole b where w.container_id = b.id and w.container_table = 'Borehole' and w.source = 'two_points'";
	map {push @_, $_->[0]} @{$_dbh->selectall_arrayref($sql, {})};
	@{$self->{"cache"}->{"getUwisWithTwoPoints"}} = @_
}

sub getUwisWithoutCheckshots {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithoutCheckshots"}} if $self->{"cache"}->{"getUwisWithoutCheckshots"};
	my %uwis;
	map {$uwis{$_} = 1} $self->getAllUwis;
	map {delete $uwis{$_}} $self->getUwisWithCheckshots;
	@{$self->{"cache"}->{"getUwisWithoutCheckshots"}} = keys %uwis
}

sub getUwisWithoutDeviations {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithoutDeviations"}} if $self->{"cache"}->{"getUwisWithoutDeviations"};
	my %uwis;
	map {$uwis{$_} = 1} $self->getAllUwis;
	map {delete $uwis{$_}} $self->getUwisWithDeviations;
	@{$self->{"cache"}->{"getUwisWithoutDeviations"}} = keys %uwis
}

sub getUwisWithoutRealDeviations {
	my $self = shift;
	return @{$self->{"cache"}->{"getUwisWithoutRealDeviations"}} if $self->{"cache"}->{"getUwisWithoutRealDeviations"};
	my %uwis;
	map {$uwis{$_} = 1} $self->getAllUwis;
	map {delete $uwis{$_}} $self->getUwisWithRealDeviations;
	@{$self->{"cache"}->{"getUwisWithoutRealDeviations"}} = keys %uwis
}

sub surveys {
	my $self = shift;
	return $self->{"cache"}=>{"surveys"} if $self->{"cache"}->{"surveys"};
	my %surveys;
	my $sql = "select name from survey_3d_area";
	map {$surveys{$_->[0]} = "3D"} @{$_dbh->selectall_arrayref($sql, {})};
	$sql = "select name from seis_2d_survey";
	map {$surveys{$_->[0]} = "2D"} @{$_dbh->selectall_arrayref($sql, {})};
	%{$self->{"cache"}->{"surveys"}} = %surveys;
	return $self->{"cache"}->{"surveys"}
}

##
## Private class methods
##

sub _GetDbHandle {
	my $proj = shift;
	my $pass = shift;
	$_dbh = DBI->connect_cached("DBI:Oracle:", $proj, $pass, {"AutoCommit" => 1})
}

1;
