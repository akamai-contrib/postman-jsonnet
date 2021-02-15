# Postman Jsonnet

Provides a library for generating Postman collections using Jsonnet.

These collections can then be imported into Postman UI, or directly run using the `newman` command-line runner.

The purpose is to simplify maintaining tests alongside configuration data, both as Jsonnet.

An example collection is provided within [`example.jsonnet`](./example.jsonnet).

## Installing

With `jsonnet-bundler`:

```bash
jb install https://github.com/akamai-contrib/postman-jsonnet
```

## Running the example

```bash
jsonnet -o build/example.json example.jsonnet
newman run build/example.json
```