#!/usr/bin/perl 

# Search for modules .pm on 'perls' dir
BEGIN {push @INC, 'scripts'}

use Patch;  # import default list of items.

set_TMPDIR( $TMPDIR ) ;

## docker
print "docker rw hosts file stupied patching __ bySabi\n";
print "-----------------------------------------------\n\n";

set_filepath ( $path_target );


set_file ( $target1 );
patch_bin__file( $pattern1, $replace1 );

## one clean por target file
clean__file_flag_tmp();


1;