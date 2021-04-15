#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use BibTeX::Parser;
    use IO::File;

my $help = 0;
my $overwrite = 0;
my $admin_name = "Cotton";

my $err = GetOptions ("admin_name=s" => \$admin_name,  
            "overwrite"   => \$overwrite,      
            "help"  => \$help);
if ($err || $help) { 
	print "error in arguments. Usage is:\n";
	print "perl $0 [options] BibTex_filename\n";
	print "options:\n";
	print "--admin_name=s\tset name of site admin, to replace in author lists\n";
	print "--overwrite\toverwite existing cite.bib\n";
	print "--help\tshow this\n";
	print "\n";
	print "Parses a BibText file and produces cite.bib stubs to add cite buttons to Hugo Academic theme\n";
	print "Intended to run *after* bib2markdown.pl which will create directories etc.\n";
}
	
my $filename = $ARGV[0];
if (! -e $filename) { 
	die("file '".$filename."' not found");
}

my $fh     = IO::File->new($filename); 
# Create parser object ...
my $parser = BibTeX::Parser->new($fh);
 
my %month_translate = ( "Jan" => "01", "Feb" => "02", "Mar" => "03", "Apr" => "04", "May" => "05", "Jun" => "06", "Jul" => "07", "Aug" => "08", "Sep" => "09", "Oct" => "10", "Nov" => "11", "Dec" => "12" );
# ... and iterate over entries
while (my $entry = $parser->next ) {
        if ($entry->parse_ok) {
		if (-e "content/publication/".$entry->key ) { 
		my $file_here = "content/publication/".$entry->key."/cite.bib";
		print "trying to write '".$file_here."'\n";   
             	if ( ! -e $file_here || $overwrite ) { 
			open(F,">",$file_here) or   die("file open returned ".$!);
			print F $entry->raw_bibtex()."\n";
			close F;
        	} else { print "file '".$file_here."' already exists\n";}
		} else { print "directory missing for ".$entry->key."\n"; }
	}
}


