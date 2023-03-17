local test = import '../postman.libsonnet';

/**
 * This test suite demonstrates how to delay requests
 */

test.suite {
  name: 'Delaying tests',
  item:
      test.case  {
      name: 'Add 5s delay before request is sent',

      // Add the delay parameter with the timeout in milliseconds
      // This will be executed before the request is sent
      delay: 5000,

      request: test.GET('https://httpbin.org/anything'),

      tests:: [
        test.assertStatusCodeEquals('test.assertStatusCodeEquals', 200),
      ],
    },
}
