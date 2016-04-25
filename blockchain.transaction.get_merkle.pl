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
my $method = "blockchain.transaction.get_merkle";

my $height = 394997;
my $transaction = "6cb18f11668ea7bdad19ee7db975c50c3f72e44c3858faecea1ee10c6826d4c9";

#Expected answer
my $blockHeader = {
    merkle => ["c0c280480c91ff31752b6b6969fc024057de30d5fc2ffe9ad56316a06ead5c01", "29e9b3900c48cf7ac82523c88dad5501b6ea4cf7062aaa315c7ffac9066cf9ec", "508c77c8a5ed6045aba1708d51fcad8ad49aaa3e96abf2239d172f60cf67663d", "ca1b0f51b12d092c7a2f18210b3a2cd5abaede495777b8e6f0f96148f708bc4c", "d5be82b205a3b49459ec2cfb10c543e79de0b05888a573601197b8fc893322a6", "985f56031fbcf0642ccd6f2c16ddb3d37a88bf188f91920510b0e905f4815b33", "0282ceaa6c29a7b8353cf8d208c4a47a58a961e7a44700d5bbfe092b54467ea9", "a45aef601f3e16139bef5084bc739f52d3175821c1e50259f1451fe37e3cc351", "06e221acda11b7c899dd0fa0b7a9ceaf631c4b284d106a0ddc27848271254cbc", "460835251b1c156c99f5847fac63eae52946f881803cde06238aadcf5e499ddd", "768bfaa02ba785bc8fffda48f8942d974fa7e31eb8e9d9f7a1fbb8e3d9b419c7", "1c4507d30da875b6645d2f26e5a423346fb1d6e4e69d6683061d872b97e80285"],
    pos  =>  5,
    block_height => 394997,
  };

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($transaction, $height);
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
