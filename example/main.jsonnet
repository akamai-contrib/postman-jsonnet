local test = import '../postman.libsonnet';

test.suite {
  name: 'Postman Jsonnet',

  // These get set as environment variables at the
  // test collection level.
  //
  // When running the test, postman/newman will interpolate
  // references like {{httpbin}} accordingly.
  //
  // Alternatively, you can also use Jsonnet external variables
  // to accomplish a similar goal.
  vars: {
    httpbin: 'httpbin.org',
  },

  item: [
    import './building-requests.jsonnet',
    import './testing-responses.jsonnet',
    import './auth.jsonnet',
    import './akamai.jsonnet',
  ],
}
