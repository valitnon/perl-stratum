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

my $height = "1";

my $method = "blockchain.block.get_header";

my $blockHeader = {
    nonce => 2573394689,
    prev_block_hash  =>  "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f",
    timestamp => 1231469665,
    merkle_root => "0e3e2357e806b6cdb1f70b54c3a3a17b6714ee1f0e68bebb44a74b1efd512098",
    block_height => 1,
    version => 1,
    bits => 486604799,
  };

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($height);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if(Compare($result, $blockHeader)){
    print "$method successfull. Response: " . Dumper($result) . "\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: " . Dumper($blockHeader). "
    \treceived: " . Dumper($result) . "\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
