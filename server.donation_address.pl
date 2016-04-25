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
my $method = "server.donation_address";

#Expected answer
my $donationAddress = ""; #Default there is no donation address

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ("");
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result eq $donationAddress){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but donation address differs:
    \tdonation address expected: $donationAddress
    \tdonation address received: $result\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
