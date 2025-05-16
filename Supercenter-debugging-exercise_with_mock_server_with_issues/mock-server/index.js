'use strict';

const Hapi = require('@hapi/hapi');
const Inert = require('@hapi/inert');
const Path = require('path');

const data = {
  config: {
    catalogSize: 14,
    forceFailure: false,
    simulatedLatency: 750
  },
  products: require('./data/products.json')
};

const init = async () => {

    const server = Hapi.server({
        port: 3000,
        host: 'localhost',
        routes: {
          files: {
            relativeTo: Path.join(__dirname, 'public')
          }
        }
    });

    await server.register(Inert);

    require('./routes/admin')(server, data);
    require('./routes/api')(server, data);

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {
    console.log(err);
    process.exit(1);
});

init();
