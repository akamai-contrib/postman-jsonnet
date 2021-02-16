local test = import '../postman.libsonnet';

/**
 * This test suite demonstrates how to build requests, from simple to complex.
 */

test.suite {
  name: 'Building Requests',

  item: [
    import './building-requests/method.jsonnet',
    import './building-requests/url.jsonnet',
    import './building-requests/headers.jsonnet',
    import './building-requests/cookies.jsonnet',
    import './building-requests/body.jsonnet',
  ],
}
