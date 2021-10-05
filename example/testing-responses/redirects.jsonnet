local test = import '../../postman.libsonnet';

test.suite {
  name: 'Redirects Assertions',

  redirectUrl:: 'https://httpbin.org/anything',

  item: [
    test.case {
      name: 'Follow Redirect Off By Default',
      request: test.GET('https://nghttp2.org/httpbin/redirect-to?url=%s' % $.redirectUrl),
      tests: [
        test.assertStatusCodeEquals('Response should be 302', 302),
        test.assertHeaderEquals('Location should be %s' % $.redirectUrl, 'Location', $.redirectUrl),
      ],
    },

    test.case {
      name: 'Follow Redirect On',
      followRedirects: true,
      request: test.GET('https://nghttp2.org/httpbin/redirect-to?url=%s' % $.redirectUrl),
      tests: [
        test.assertStatusCodeEquals('Response should be 200', 200),
      ],
    },
  ],
}
