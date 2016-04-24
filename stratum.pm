#!/usr/bin/perl
# Lucas Betschart - lclc <lucasbetschart@gmail.com>
# Apache License
# April 2016
##################################################

package stratum;

use strict;
use warnings;
use IO::Socket::INET;

#Use modified version of JSON::RPC2 due to non-standard JSON-RPC of the protocol
use FindBin;
use lib "$FindBin::Bin/perl-JSON-RPC2/lib/";
use JSON::RPC2::Client;

our $VERSION = 0.1;

my $verbose = 1;
my $defaultServer = "stratum-az-wusa.airbitz.co"; # Python Server
# my $defaultServer = "b.1209k.com"; # Java Server (jelectrum)

my ($client, $socket);

sub new {
  my $server = shift;
  if (!defined $server){
    $server = $defaultServer;
  }

  $client = JSON::RPC2::Client->new();

  print "Connecting to $server...\n" if $verbose;
  $socket = new IO::Socket::INET (
    PeerAddr => $server,
    PeerPort => 50001,
    Proto => 'tcp',
    Timeout => 2,
    ) || die "Error - Could not connect to the server: $!\n";
  print "Connected.\n\n" if $verbose;
}

sub sendToElectrum
{
  my $method = $_[0];
  my @params = @{$_[1]};

  my $json_request = $client->call($method, @params);
  print "Request: $json_request\n" if $verbose;

  my $size = $socket->send("$json_request\n");
  print "Sent $size bytes\n" if $verbose;

  my $json_response = <$socket>;
  print "Response: $json_response\n" if $verbose;

  my ($failed, $result, $error) = $client->response($json_response);
  if ($failed) {
    return 0,"bad response: $failed";
  } elsif ($error) {
    return 0, "failed with code=%d: %s\n",
    $error->{code}, $error->{message};
  } else {
    return 1, $result;
  }
}

sub close {
  $socket->close();
}

1;
