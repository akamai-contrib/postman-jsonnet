local test = import '../../postman.libsonnet';

test.suite {
  name: 'URL',

  item: [
    test.case {
      name: 'Simple',
      request: test.GET('https://httpbin.org/anything?foo=bar&foo=baz#urlfragment')
    },

    test.case {
      name: 'Structured',
      request: test.GET({
        protocol: 'https',
        host: 'httpbin.org',
        path: '/anything',
        hash: 'urlfragment',
        query: [
          {key: 'foo', value: 'bar'},
          {key: 'foo', value: 'baz'},
        ],
      })
    },
  ],
}
