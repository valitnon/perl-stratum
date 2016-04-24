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

my $address = "15MbykpnH6uhuLPmUxWSB4L7CBY7DChDfK";
my $method = "blockchain.address.get_history";

my $history =[
  {
    tx_hash => 'e2f78b9fe2c8c63af4829081cfde576f1c88969d54659e61a45b2c9fd22a43c3',
    height => 291193,
  },
  {
    tx_hash => '9a43de93e66ad4696e5c07cf31356b2e1780fe110d794f63979d72b08c4e8339',
    height => 291406,
  },
];

my $verbose = 0;

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($address);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if(Compare($result, $history)){
    print "$method successfull. Response: " . Dumper($result) . "\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: " . Dumper($history). "
    \treceived: " . Dumper($result) . "\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
