local test = import "../postman.libsonnet";

test.suite {
  name: "Postman Jsonnet",

  item: [
    import './assertions.jsonnet',
    import './request-body.jsonnet',
    import './akamai.jsonnet',
  ],
}
