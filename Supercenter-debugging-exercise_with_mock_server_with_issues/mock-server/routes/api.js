'use strict';

const Boom = require('@hapi/boom');
const Joi = require('@hapi/joi');

module.exports = function (server, data) {

  const checkSimulatedLatency = async (request, h) => {
    await new Promise(resolve => setTimeout(resolve, data.config.simulatedLatency || 0));
    return h.continue;
  };
  
  const checkForceFailure = (request, h) => {
    if (data.config.forceFailure) {
      throw Boom.internal('data.config.forceFailure flag is ON');
    }
    return h.continue;
  };

  server.route({
    method: 'GET',
    path: '/api/products/{pageNumber}/{pageSize}',
    handler: async (request, h) => {
      const pageNumber = request.params.pageNumber;
      const pageSize = request.params.pageSize;

      const start = (pageNumber - 1) * pageSize;
      const end = start + pageSize;

      const products = data.products.slice(0, data.config.catalogSize).slice(start, end);
      const totalProducts = data.config.catalogSize;
      const statusCode = products.includes(null) ? 206 : 200; // Partial content if there are any `null` entries

      return h.response({products, totalProducts, statusCode}).code(statusCode);
    },
    options: {
      pre: [
        { method: checkSimulatedLatency },
        { method: checkForceFailure },
      ],
      validate: {
        params: {
          pageNumber: Joi.number().integer().min(1).required(),
          pageSize: Joi.number().integer().min(1).max(30).required()
        }
      }
    }
  });

  server.route({
    method: 'GET',
    path: '/images/{imageName}',
    handler: async (request, h) => {
      return h.file(`images/${request.params.imageName}`);
    },
    options: {
      pre: [
        { method: checkSimulatedLatency },
        { method: checkForceFailure },
      ],
      validate: {
        params: {
          imageName: Joi.string().required()
        }
      }
    }
  });
};
