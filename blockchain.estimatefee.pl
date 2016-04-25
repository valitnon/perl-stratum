#!/usr/bin/perl
# Lucas Betschart - lclc <lucasbetschart@gmail.com>
# Apache License
# April 2016
##################################################

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/";
use stratum;

my $verbose = 0;

my $nrOfBlocks = 1; #to be included within a certain number of blocks

my $method = "blockchain.estimatefee";

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($nrOfBlocks);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  print "$method successfull. Response: $result\n";
}
else{
  exit 1;
}

stratum::close();
