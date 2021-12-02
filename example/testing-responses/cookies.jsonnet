local test = import '../../postman.libsonnet';

test.suite {
  name: 'Cookie Assertions',

  item: [
    test.case {
      name: 'Cookie assertions',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=chocolate%3Dchip'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieExists('test.assertCookieExists', 'chocolate'),
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'caramel'),
        test.assertCookieEquals('test.assertCookieEquals', 'chocolate', 'chip'),
        test.assertCookieDoesNotEqual('test.assertCookieEquals', 'chocolate', 'chop'),
        test.assertCookieMatches('test.assertCookieMatches', 'chocolate', 'ch.p'),
        test.assertCookieDoesNotMatch('test.assertCookieDoesNotMatch', 'chocolate', 'ch.t'),
      ],
    },
  ],
}
