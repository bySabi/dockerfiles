package Patch; #bySabi

use warnings;
use 5.01;
use Exporter;

our @ISA= qw( Exporter );

# these are exported by default.
our @EXPORT = qw( patch_bin__file
				patch_text__file
				patch_text_nlines__file
				set_TMPDIR
				set_file set_filepath
				set_EOL
				set_windows
				clean__file_flag_tmp
				touch_file
				);

my $filepath;
my $file;
my $TMPDIR;
my $file_tmp;
my $iswindows = 0;
my $file_flag_tmp;

my $EOL = "\n";

my $pattern;
my $pattern2;
my $replace;
my $nlines = 0;

my $buffer;
my $unpack_data;
my $patch = 0;


sub set_file { $file = shift }
sub set_filepath { $filepath = shift }
sub set_TMPDIR { $TMPDIR = shift }
sub set_file_tmp { $file_tmp = "${TMPDIR}/.${file}.tmp" }
sub set_EOL { $EOL = shift }
sub set_windows { $iswindows = 1 }



sub open_file {
	open FP, $filepath.$file or die 'CAN!!! not open file: '.$filepath.$file."\n";
	isnotpatched_backup_file__first();
	set_file_tmp();
}


### --------------------------- BIN FILE PATCH -------------------------------------------------

sub patch_bin__file {
	open_file();
	binmode FP;

	patch_bin(@_);
	close_files();
	
	if ( $patch == 1 ) {
		unlink $file_tmp or die 'can not delete file: '.$file_tmp."\n";
		say $filepath.$file." | It has been patched";
	}
	if ( $patch == 2 ) {
		rename $file_tmp, $filepath.$file or die 'file: '.$filepath.$file.'  Insufficient privileges, please switch the root account.';
		chmod 0755, $filepath.$file or die 'file: '.$filepath.$file.'  Insufficient privileges, please switch the root account.';
		touch_backup_file();	
		say $filepath.$file." | patched successful";
	} else {
		say 'error';
	}
	touch_backup_file();
}

sub patch_bin {
	my $pattern = shift;
	my $replace = shift;

	open TMPFP, '>', $file_tmp or die 'can not open file: '.$file_tmp."\n";

	while(read(FP, $buffer, 1024)) {
		$unpack_data = unpack('H*', $buffer);
		if ($unpack_data =~ s/$pattern/$replace/){
			$buffer = pack('H*', $unpack_data);
			$patch = 2;
		}
		syswrite(TMPFP, $buffer, length($buffer));
	}
	return $patch;
}

### --------------------------- TEXT FILE PATCH -------------------------------------------------

sub patch_text__file {
	__patch_text__file(@_, \&patch_text)
}

sub patch_text_nlines__file {
	__patch_text__file(@_, \&patch_text_nlines)	
}

sub __patch_text__file {
	open_file();
	
	## Function reference
	my $patch_func = $_[3];
	$patch_func->($_[0], $_[1], $_[2]);
	close_files();
	
	if ( $patch == 1 ) {
		unlink $file_tmp or die 'can not delete file: '.$file_tmp."\n";
		say $filepath.$file." | It has been patched";
	}
	if ( $patch == 2 ) {
		rename $file_tmp, $filepath.$file or die 'file: '.$filepath.$file.'  Insufficient privileges, please switch the root account.';
		touch_backup_file();
		say $filepath.$file." | patched successful";
	} else {
		say 'error';
	}
}

# Replace lines between 'pattern and pattern2' with 'replace'
# pattern and pattern2 are keeped
sub patch_text {
	my ($pattern, $pattern2, $replace) = @_;

	open TMPFP, '>', $file_tmp or die 'can not open file: '.$file_tmp."\n";
	binmode TMPFP;

	while( <FP> )
	    {
    	chomp;        # strip off EOL (\r\n on windows files)  

    	#write to TMPFP line read ($_) from FP
	    print TMPFP $_ . $EOL;   # Add LF myself for cross platform
		if ($_ =~ m/$pattern/) {
			while( <FP> )
			{
				if ($_ =~ m/$pattern2/) {
					print TMPFP $replace;
					print TMPFP $EOL;
					$patch = 2;
					last;
				}	
			}	
		}
	}
	return $patch;
}

# Replace n lines after 'pattern' with 'replace'
# pattern are keeped
sub patch_text_nlines {
	my ($pattern, $nlines, $replace) = @_;

	open TMPFP, '>', $file_tmp or die 'can not open file: '.$file_tmp."\n";
	binmode TMPFP;

	while( <FP> )
	    {
    	chomp;        # strip off EOL (\r\n on windows files)  
	
    	#write to TMPFP line read ($_) from FP concat(.) my endofline 
	    print TMPFP $_ . $EOL;   # Add LF myself for cross platform
		if ($_ =~ m/$pattern/) {
			while( <FP> )
			{
				if ( ! --$nlines ) {
					print TMPFP $replace;
					$patch = 2;
					last;
				}	
			}	
		}
	}
	close_files();
	return $patch;
}


sub isnotpatched_backup_file__first {
	my $file_src =  $filepath.$file;
	my $file_dest = $filepath.$file.".orig";
	$file_flag_tmp = $TMPDIR."/".$file.".working";
	if ( -e $file_flag_tmp) {
		return;
	}
	if ( -e $file_dest ) {
		my $file_src_mtime = (stat ($file_src))[9];
		my $file_dest_mtime = (stat ($file_dest))[9];
		# if file_src is more old than file_dest then patched
		if (  $file_src_mtime < $file_dest_mtime ) {
			die "Already patched!!!: "."\n"."\n"."\t REVIEW THIS FILE FIRST \n"."\n".$file_src."\n".$file_dest."\n".$file_flag_tmp."\n"."\n";
		}
		unlink $file_dest or die 'can not delete file: '.$file_dest."\n";
	} 
	copy_file($file_src, $file_dest) or die "Fail backup file: ".$file_src."\n";
	touch_file( $file_flag_tmp );
}


sub copy_file {
	my ($file_src, $file_dest)  = @_;
	# on windows use cp command from cmd
	if ( $iswindows ) {
		my $out=`copy $file_src $file_dest`; !($?) or die $out;
		return  1;
	} else {
		# to avoid include unneeded modules on windows. use at runtime.
		require File::Copy;
		my $cp = \&File::Copy::copy;
		$cp->($file_src, $file_dest);
		if ( $! ) { return 0; }
		return 1;
	}
}

sub touch_file {
	my $file = shift;
	my $now = time;
	# add 1 to mtime and atime
	if ( ! (-e $file) ) {
		open my $fh, '>', $file or die "Can't create file: ".$file." $!\n";
		print $fh "";
	}
	utime $now+1, $now+1, $file or die "problem touching file: $file"."\n";
}

sub touch_backup_file {
	touch_file ( $filepath.$file.".orig" );
}

sub close_files {
	close(FP);    
	close(TMPFP);
}

sub clean__file_flag_tmp {
	unlink $file_flag_tmp;
}

1;
