local test = import '../../postman.libsonnet';

test.suite {
  name: 'Method',

  item: [
    test.case {
      name: 'GET',
      request: test.GET('https://{{httpbin}}/anything'),
    },
    test.case {
      name: 'HEAD',
      request: test.HEAD('https://{{httpbin}}/anything'),
    },
    test.case {
      // most common methods have a convenience constructor,
      // but if there isn't one, this is perfectly fine
      name: 'DAV : PROPFIND',
      request: {
        method: 'PROPFIND',
        url: 'https://{{httpbin}}/anything',
      },
    },
  ],
}
