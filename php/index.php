<?php
require_once __DIR__.'/vendor/autoload.php';

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Camcima\GeoHash;

$app = new Silex\Application();
$app->register(new Igorw\Silex\ConfigServiceProvider(__DIR__ . "/../config.yml"));

$app['db'] = $app->share(function ($app) {
    $host = $app['mongodb']['host'] . ':' . $app['mongodb']['port'];
    $user = $app['mongodb']['username'];
    $password = $app['mongodb']['password'];
    $database = $app['mongodb']['database'];

    $auth = $user && $password ? "{$user}:{$password}@" : '';
    $connectionString = "mongodb://{$auth}{$host}";
    $connection = new \MongoClient($connectionString);

    return $connection->$database;
});

$app->before(
    function (Request $request) use ($app) {
        $requestPayload = $request->getContent();
        $requestPayloadData = json_decode($requestPayload, true);

        if (!empty($requestPayloadData)) {
            $request->request->replace($requestPayloadData);
        }
    }
);

$app->put('taxi-position', function (Request $request) use ($app) {
    $jsonRequest = $request->request->getIterator();

    $collection = $app['db']->selectCollection($app['mongodb']['collection']);

    $criteria = ['_id' => new \MongoId('556018800640fd52df330d31')];

    $geohash = new GeoHash;
    $geohash->setLatitude($jsonRequest['lat']);
    $geohash->setLongitude($jsonRequest['long']);

    $positionRecord = [
        'lat' => $jsonRequest['lat'],
        'long' => $jsonRequest['long'],
        'geohash' => $geohash->getHash()
    ];
    $flags = ['upsert' => 1];
    $collection->update($criteria, $positionRecord, $flags);

    return new Response(null, 204);
});

$app->run();
