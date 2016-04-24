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

#my $bannerText = "Welcome to Electrum!"; #Default banner text
my $bannerText = "Welcome to the Airbitz Electrum Server!";
my $method = "server.banner";

my $verbose = 0;

stratum::new();

print "Testing $method method..\n" if $verbose;
my @params = ("");
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result eq $bannerText){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but banner text differs:
    \tbanner text expected: $bannerText
    \tbanner text received: $result\n";
  }
}

stratum::close();
