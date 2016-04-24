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

my $address = "1JZVW1eiHqRKMbsvYzkDgPk5UqYwhNwnRz";
my $method = "blockchain.address.listunspent";

my $utxos =[
  {
    tx_pos => 0,
    tx_hash => '099a702ef506850d70b15d3bed19ada3a1fde5a403b35a11256fcfb581ee3372',
    height => 266038,
    value => 10000,
  },
];

my $verbose = 0;

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($address);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if(Compare($result, $utxos)){
    print "$method successfull. Response: " . Dumper($result) . "\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: " . Dumper($utxos). "
    \treceived: " . Dumper($result) . "\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
