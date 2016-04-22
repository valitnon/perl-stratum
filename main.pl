#!/usr/bin/perl
# Lucas Betschart - lclc <lucasbetschart@gmail.com>
# github.com/lclc/perl-stratum
# Apache License
# April 2016
##################################################

 use strict;
use warnings;
use IO::Socket::INET;

#Use modified version of JSON::RPC2 due to non-standard JSON-RPC of the protocol
use FindBin;
use lib "$FindBin::Bin/perl-JSON-RPC2/lib/";
use JSON::RPC2::Client;

my $verbose = 0;
my $electrumServer = "stratum-az-wusa.airbitz.co"; # Python Server
# my $electrumServer = "b.1209k.com"; # Java Server (jelectrum)
my $serverProtocolVersion = 1.0;

my $client = JSON::RPC2::Client->new();

print "Connecting to $electrumServer...\n" if $verbose;
my $socket = new IO::Socket::INET (
  PeerAddr => $electrumServer,
  PeerPort => 50001,
  Proto => 'tcp',
  Timeout => 2,
  ) || die "Error - Could not connect to the server: $!\n";
print "Connected.\n\n" if $verbose;

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

###### server.version
print "Calling server.version method..\n" if $verbose;
my @params = ("1.9.5", "0.6");
my ($success,$result) =  sendToElectrum("server.version", \@params);
if($success){
  if($result == $serverProtocolVersion){
    print "server.version successfull. Response: $result\n";
  }
  else{
    print "server.version successfull, but version differs:
    \tVersion expected: $serverProtocolVersion
    \tVersion received: $result\n";
  }
}

$socket->close();
