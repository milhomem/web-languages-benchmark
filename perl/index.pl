#!/usr/bin/env perl
use Mojolicious::Lite;

app->plugin('yaml_config', {
    file => '../config.yml',
});

app->config(hypnotoad => {listen => ['http://*:' . app->stash('config')->{proxy}{listen}]});

app->plugin('mongodb', { 
    host => app->stash('config')->{mongodb}{host},
    port => app->stash('config')->{mongodb}{port},
    helper => 'db',
});

put '/taxi-position' => sub {
    my $controller = shift;
    my $jsonRequest = $controller->req->json;

    my $databaseConfig = app->stash('config')->{mongodb};
    app->db($databaseConfig->{database});
    my $collection = app->coll($databaseConfig->{collection});

    my $criteria = { '_id' => MongoDB::OID->new('556018800640fd52df330d31') };
    my $positionRecord = {'lat' => $jsonRequest->{'lat'}, 'long' => $jsonRequest->{'long'}};
    my $flags = {'upsert' => 1};
    $collection->update($criteria, $positionRecord, $flags);

    return $controller->respond_to(json => { json => {}, status => 204});
};

app->start;
