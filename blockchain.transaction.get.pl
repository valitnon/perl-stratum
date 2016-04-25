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
my $method = "blockchain.transaction.get";

my $txHash = "6cb18f11668ea7bdad19ee7db975c50c3f72e44c3858faecea1ee10c6826d4c9";

#Expected answer
my $rawTx = "0100000003a003aa801d70951700c75f0f232153e85ab3906b6f4e4c2aac0948f9412b406f030000006a47304402203c986d69c747d50dbc6d9cfcbecd33e83a8cbff7f1de077e95157b3f3e7ad336022044b3c620d905899756d0eb8fbcba996d4bf4479e48d431f4469ac1be036b68d501210360897e037967861e255ad97f62a2eb425712e712f587847e01d1dd967d2e6671ffffffff1f26a2ed5c2dc26672c664e8352fb605130a9ecb25f5585ec4154969b4b3d671070000006b483045022100c40c37b2496df051f98e0857acdff462f40b11bd9e832d672fa6021494c4753a0220246a6c89859288312c9e109dc8524b1e8d41ddd7727880fbdeb3b4737bad76c901210360897e037967861e255ad97f62a2eb425712e712f587847e01d1dd967d2e6671ffffffffd189d34ca5f6937e168dc8ab377afc3d9a1cb42b9f0710a10a776fe0fae8ac79030000006b483045022100c38452e97337501b41f2131a66c7bb53823a6de499773dacfb5fced10bb5a5230220681cec03204404a689344360eac89ca01724b622f9beb41b164a741322868df001210360897e037967861e255ad97f62a2eb425712e712f587847e01d1dd967d2e6671ffffffff045b8e80170000000017a91460d9962367d98e5a11e7eeb522b1fc74750edcee875b8e80170000000017a91489ab0906325d7674bf66328751ee11d9825e4e4d875b8e80170000000017a9149f89ceeaae413dabd2b9e035788db6e634fe4983875e8e80170000000017a9143fefcf4332a1103040d23e5f43d02a964606bf038700000000";

stratum::new($ARGV[0]);

print "Testing $method method..\n" if $verbose;
my @params = ($txHash);
my ($success,$result) = stratum::sendToElectrum($method, \@params);
if($success){
  if($result eq $rawTx){
    print "$method successfull. Response: $result\n";
  }
  else{
    print "$method successfull, but result differs:
    \texpected: $rawTx
    \treceived: $result\n";
    exit 1;
  }
}
else{
  exit 1;
}

stratum::close();
