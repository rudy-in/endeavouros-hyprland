#!/usr/bin/env perl

use strict;
use warnings;

# Set default values
my $t_warn = $ENV{T_WARN} || 70;
my $t_crit = $ENV{T_CRIT} || 90;
my $chip = $ENV{SENSOR_CHIP} || "";

# Get chip temperature
open (SENSORS, "sensors -u $chip |") or die;
my $temperature = -9999;
while (<SENSORS>) {
    if (/^\s+temp1_input:\s+[\+]*([\-]*\d+\.\d)/) {
        $temperature = $1;
        last;
    }
}
close(SENSORS);

# Check if temperature is found
$temperature eq -9999 and die 'Cannot find temperature';

# Set default label and color
my $label = '';
my $color = '#85C1DC';  # Default color is blue

# Change label and color based on temperature
if ($temperature < 45) {
    $label = '';
    $color = '#85C1DC';  # Blue color
} elsif ($temperature < 55) {
    $label = '';
    $color = '#f5a97f';  # Orange color
} elsif ($temperature < 65) {
    $label = '';
    $color = '#f5a97f';  # Orange color
#    # Color remains blue by default
} elsif ($temperature < 75) {
    $label = '';
    $color = '#FD807E';  # Red color
}

# Print short_text, full_text
print "<span foreground='$color'>$label $temperature°C</span>\n";

# Print color, if needed both text and flame
if ($temperature >= $t_crit) {
    print "#FD807E\n";  # Red color
    exit 33;
} elsif ($temperature >= $t_warn) {
    print "#f5a97f\n";  # Orange color
} else {
    print "#85C1DC\n";  # Blue color
}

# Use this version if you want only the flame will change color
#if ($temperature >= $t_crit) {
#    exit 33;
#} elsif ($temperature >= $t_warn) {
#    exit 33;
#} else {
#   exit 0;
#}

