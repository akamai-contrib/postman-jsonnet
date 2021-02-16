local test = import "./postman.libsonnet";

test.suite {
  name: "Postman Jsonnet",

  item: [
    import './example/assertions.jsonnet',
    import './example/request-body.jsonnet',
    import './example/akamai.jsonnet',
  ],
}
