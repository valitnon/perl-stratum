#!/usr/bin/perl
# Lucas Betschart - lclc <lucasbetschart@gmail.com>
# Apache License
# April 2016
##################################################

use strict;
use warnings;
use Data::Compare;
use Data::Dumper;
use JSON;

use FindBin;
use lib "$FindBin::Bin/";
use stratum;

my $verbose = 0;

my $address = "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L";
my $method = "blockchain.address.get_balance";

my $balance = {
    confirmed => 90085204083,
    unconfirmed  =>  0,
  };

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($address);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if(Compare($result, $balance)){
    print "$method successfull. Response: " . Dumper($result) . "\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: " . Dumper($balance). "
    \treceived: " . Dumper($result) . "\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
