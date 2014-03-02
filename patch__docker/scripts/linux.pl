#!/usr/bin/perl

$TMPDIR = "/tmp";

# Search for modules .pm on 'perls' dir
BEGIN {push @INC, 'scripts'}

use Patch;  # import default list of items.

$path_target = "/usr/bin/";
$target1 = "docker";

$pattern1 = "62696e642c726f";
$replace1 = "62696e642c7277";

require "scripts/patch.pl";

exit 0;
