'use strict';

const Joi = require('@hapi/joi');

module.exports = function (server, data) {
  const maxCatalogSize = data.products.length;

  server.route({
    method: 'GET',
    path: '/',
    handler: async (request, h) => {
      return h.file('admin.html');
    }
  });
  
  server.route({
    method: 'GET',
    path: '/admin/config',
    handler: async () => {
      return Object.assign({}, data.config, { maxCatalogSize });
    }
  });

  server.route({
    method: 'POST',
    path: '/admin/config',
    handler: async (request) => {
      Object.assign(data.config, request.payload);
      return {};
    },
    options: {
      validate: {
        payload: {
          catalogSize: Joi.number().integer().min(0).max(maxCatalogSize),
          forceFailure: Joi.boolean(),
          simulatedLatency: Joi.number().integer().min(0),
        }
      }
    }
  });
};
