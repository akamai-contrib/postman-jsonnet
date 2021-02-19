local test = import "../postman.libsonnet";

test.suite {
  name: "Postman Jsonnet",

  item: [
    import './building-requests.jsonnet',
    import './testing-responses.jsonnet',
    import './auth.jsonnet',
    import './akamai.jsonnet',
  ],
}
