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

my $tx = "099a702ef506850d70b15d3bed19ada3a1fde5a403b35a11256fcfb581ee3372";
my $position = 0;
my $result_address= "1JZVW1eiHqRKMbsvYzkDgPk5UqYwhNwnRz";

my $method = "blockchain.utxo.get_address";

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($tx, $position);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result eq $result_address){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: $result_address
    \treceived: $result\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
