# Supercenter App Mock Server

This is a mock server for the Supercenter app. It can serve up a paginated list of products, and their associated images.

## Usage

1. Install node modules:

```sh
npm install
```

2. Start the server:

```sh
npm start
```

> Note: If that does not work, you can run the server directly with `node index.js`.

## Configuration

There are a few configurable options that can be configured via the [Admin Page](http://localhost:3000). (The options are documented there.)

## Endpoints

- Paginated products: http://localhost:3000/supercenter-api/products/{pageNumber}/{pageSize} – [Example](http://localhost:3000/api/products/1/20)
- Product images: http://localhost:3000/images/{imageName} – [Example](http://localhost:3000/images/f51cc396-852d-4f84-b0d5-c73a167b67ab_3.c92fc51dbc9914c1700085600ad6d7f1_450.jpeg)
