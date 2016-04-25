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
my $method = "server.version";

my $clientVersion = "1.9.5";
my $protocolVersion = "0.6";

#Expected answer
my $serverProtocolVersion = 1.0;

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($clientVersion, $protocolVersion);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result == $serverProtocolVersion){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but version differs:
    \tVersion expected: $serverProtocolVersion
    \tVersion received: $result\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
