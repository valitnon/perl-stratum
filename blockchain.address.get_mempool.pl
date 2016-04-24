#!/usr/bin/perl
# Lucas Betschart - lclc <lucasbetschart@gmail.com>
# Apache License
# April 2016
##################################################

use strict;
use warnings;
use Data::Compare;
use Data::Dumper;

use FindBin;
use lib "$FindBin::Bin/";
use stratum;

my $verbose = 0;

my $address = "15MbykpnH6uhuLPmUxWSB4L7CBY7DChDfK";
my $method = "blockchain.address.get_mempool";

my $mempool =[]; #Empy unless tx in mempool
# my $mempool =[
#   {
#     tx_hash => 'e2f78b9fe2c8c63af4829081cfde576f1c88969d54659e61a45b2c9fd22a43c3',
#     height => 291193,
#   },
# ];

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($address);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if(Compare($result, $mempool)){
    print "$method successfull. Response: " . Dumper($result) . "\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: " . Dumper($mempool). "
    \treceived: " . Dumper($result) . "\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
