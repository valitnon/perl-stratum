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
my $method = "blockchain.relayfee";

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ("");
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  print "$method successfull. Response: $result\n";
}
else{
  exit 1;
}

stratum::close();
