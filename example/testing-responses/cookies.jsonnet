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
    test.case {
      name: 'Cookie attribute assertions',
      //Cookie name/value pair needs to be encoded separately from attributes, because test.utils.encodeQuery() returns value sorted by names
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s%%3BDomain%%3D{{httpbin}}' % [
        test.utils.encodeQuery({
          gold: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Expires: 'Sun, 01-Jan-2999 03:01:00 CET',
          Path: '/response-headers',
          SameSite: 'None',
          Secure: true,
          Partionned: true,
          HttpOnly: true,
          'attribute-name': '"attribute-value"',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Path', 'gold', 'Path'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist OtherAttribute', 'gold', 'OtherAttribute'),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Path', 'gold', 'Path', '/response-headers'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Path', 'gold', 'Path', '/other/path'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Path', 'gold', 'Path', '/.*'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Path', 'gold', 'Path', '/.th.r/p.th'),

        // Attribute names follow convention in https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12

        // TODO: This assertion will work after https://github.com/akamai-contrib/postman-jsonnet/issues/4
        //test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Domain', 'gold', 'Domain', '{{httpbin}}'),
        // Timezone of Expires is converted to GMT. Its value is not modified when Max-Age is not sent.
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Expires', 'gold', 'Expires', 'Tue, 01 Jan 2999 03:01:00 GMT'),
        // Value of Max-age is 0 when it is not sent
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Max-Age', 'gold', 'Max-Age', 0),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Path', 'gold', 'Path', '/response-headers'),
        // For attributes Secure and HttpOnly that are present without a value, their value is boolean true
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Secure', 'gold', 'Secure', true),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals HttpOnly', 'gold', 'HttpOnly', true),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals SameSite', 'gold', 'SameSite', 'None'),
        // For other attributes that are present without a value, their value is empty string
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Partionned', 'gold', 'Partionned', ''),
        // Bad whiste spaces before attribute value and double quotes surrounding it are ignored
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals attribute-name', 'gold', 'attribute-name', 'attribute-value'),
      ],
    },
    test.case {
      name: 'Cookie assertions - Cookie received in previous test case and still valid is still available',
      request: test.GET('https://{{httpbin}}/response-headers'),

      disableCookies: false,

      tests: [
        test.assertCookieExists('test.assertCookieExists chocolate', 'chocolate'),
      ],
    },
    test.case {
      name: 'Cookie assertions - Cookie received for another domain is not set',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s' % [
        test.utils.encodeQuery({
          vibranium: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Domain: 'other.domain',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'vibranium'),
      ],
    },
    test.case {
      name: 'Cookie assertions - Cookie received for another path is not set',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s' % [
        test.utils.encodeQuery({
          cavorite: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Path: '/other',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'cavorite'),
      ],
    },
    test.case {
      name: 'Cookie assertions - Cookie received with Expires in the past is not set',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s' % [
        test.utils.encodeQuery({
          carbonadium: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Expires: 'Fri, 01-Jan-1971 01:01:00 GMT',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'carbonadium'),
      ],
    },
    test.case {
      name: 'Cookie assertions - Cookie received with Max-age=0 and Expires in the future is not set',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s' % [
        test.utils.encodeQuery({
          adamantium: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Expires: 'Sun, 01-Jan-2999 03:01:00 GMT',
          'Max-Age': '0',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'adamantium'),
      ],
    },
    test.case {
      name: 'Cookie assertion and cookie attribute assertions - Cookie, value and attribute empty or not sent',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3B%s' % [
        test.utils.encodeQuery({
          silver: '',
        }, '%3B'),
        test.utils.encodeQuery({
          'attribute-name': true,
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        //When cookie is not set, its attributes don't exist
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist Domain', 'other-cookie', 'Domain'),
        // TODO: this assertion will work after https://github.com/akamai-contrib/postman-jsonnet/issues/5
        // When value is absent in Set-Cookie, it should be empty string
        //test.assertCookieEquals('test.assertCookieEquals', 'silver', ''),
        // TODO: This assertion will work after https://github.com/akamai-contrib/postman-jsonnet/issues/4
        // When Domain is absent , it is hostname in URL
        //test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Domain', 'silver', 'Domain', '{{httpbin}}'),
        // When Expires is absent, it is null
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Expires', 'silver', 'Expires', null),
        // When Max-Age is absent, it is 0
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Max-Age', 'silver', 'Max-Age', 0),
        // When Path is absent, it is /
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Path', 'silver', 'Path', '/'),
        // When secure and HttpOnly are absent, they are false
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Secure', 'silver', 'Secure', false),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals HttpOnly', 'silver', 'HttpOnly', false),
        // When Partitionned and SameSite are absent, they doesn't exist
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist Partitionned', 'silver', 'Partitionned'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist SameSite', 'silver', 'SameSite'),
        // When other attribute is sent with empty value, it is empty string
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals attribute-name', 'silver', 'attribute-name', ''),
        // When other attribute is absent, it doesn't exist
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist other-attribute', 'silver', 'other-attribute'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - Value of Expires is lowered to now + Max-Age',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=%s%%3D%s' % [
        test.utils.encodeQuery({
          copper: 'chip',
        }, '%3B'),
        test.utils.encodeQuery({
          Expires: 'Sun, 01-Jan-2999 01:01:00 GMT',
          'Max-Age': '600',
        }, '%3B'),
      ]),

      disableCookies: false,

      tests: [
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Expires', 'copper', 'Expires', '.*2999.*'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Max-Age', 'copper', 'Max-Age', '600'),
      ],
    },
  ],
}
