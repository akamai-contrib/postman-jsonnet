local test = import '../postman.libsonnet';

/**
 * This test suite demonstrates how to build requests, from simple to complex.
 */

test.suite {
  name: 'Testing Responses',

  item: [
    import './testing-responses/status-code.jsonnet',
    import './testing-responses/headers.jsonnet',
    import './testing-responses/cookies.jsonnet',
    import './testing-responses/body.jsonnet',
    import './testing-responses/redirects.jsonnet',
  ],
}
