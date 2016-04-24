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

my $serverProtocolVersion = 1.0;
my $method = "server.version";

my $verbose = 0;

stratum::new();

print "Testing $method method..\n" if $verbose;
my @params = ("1.9.5", "0.6");
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result == $serverProtocolVersion){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but version differs:
    \tVersion expected: $serverProtocolVersion
    \tVersion received: $result\n";
  }
}

stratum::close();