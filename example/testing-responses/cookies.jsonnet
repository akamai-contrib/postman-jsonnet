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
      name: 'Cookie assertions - cookie for another domain is not set ',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=iron%3Dchip%3BDomain%3Dother.domain'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'iron'),
      ],
    },
    test.case {
      name: 'Cookie assertions - cookie for another path is not set ',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=rust%3Dchip%3BPath%3D/other'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieDoesNotExist('test.assertCookieDoesNotExist', 'rust'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - no value and no attribute added',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=silver%3D'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeExists('test.assertCookieAttributeExists value', 'silver', ''),
        test.assertCookieExists('test.assertCookieExists', 'silver'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Domain', 'silver', 'Domain'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Path', 'silver', 'Path'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Max-Age', 'silver', 'Max-Age'),

        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist value', 'absent', ''),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist Expires', 'silver', 'Expires'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist Secure', 'silver', 'Secure'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist HttpOnly', 'silver', 'HttpOnly'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist SameSite', 'silver', 'SameSite'),
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist SameSite', 'silver', 'absent'),

        //When pseudo attribute cookie value in not in Set-Cookie, it is empty string
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals value', 'silver', '', ''),
        test.assertCookieEquals('test.assertCookieEquals', 'silver', ''),
        //When Domain is not in Set-Cookie, it matches is hostname in URL
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Domain', 'silver', 'Domain', 'httpbin.org'),
        //When Path is not in Set-Cookie, it matches is /
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Path', 'silver', 'Path', '/'),
        //When Path is not in Set-Cookie, it is 0
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Max-Age', 'silver', 'Max-Age', 0),

        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual value', 'silver', '', 'other'),
        test.assertCookieDoesNotEqual('test.assertCookieEquals', 'silver', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Domain', 'silver', 'Domain', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Path', 'silver', 'Path', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Max-Age', 'silver', 'Max-Age', 'other'),

        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches value', 'silver', '', '^$'),
        test.assertCookieMatches('test.assertCookieMatches', 'silver', '^$'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Domain', 'silver', 'Domain', '.*'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Path', 'silver', 'Path', '/'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Max-Age', 'silver', 'Max-Age', '0'),

        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch value', 'silver', '', 'other'),
        test.assertCookieDoesNotMatch('test.assertCookieDoesNotMatch', 'silver', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Domain', 'silver', 'Domain', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Path', 'silver', 'Path', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Max-Age', 'silver', 'Max-Age', 'other'),

        /*
        Fails due to expected 'Attribute found false' to equal 'Attribute found true':
          test.assertCookieAttributeMatches('FAILS: test.assertCookieAttributeMatches value', 'absent', '', '.*'),
          test.assertCookieAttributeMatches('FAILS: test.assertCookieAttributeMatches Expires', 'silver', 'Expires', '.*'),
          test.assertCookieAttributeMatches('FAILS: test.assertCookieAttributeMatches Secure', 'silver', 'Secure', '.*'),
          test.assertCookieAttributeMatches('FAILS: test.assertCookieAttributeMatches HttpOnly', 'silver', 'HttpOnly', '.*'),
          test.assertCookieAttributeMatches('FAILS: test.assertCookieAttributeMatches SameSite', 'silver', 'SameSite', '.*'),

          test.assertCookieAttributeDoesNotMatch('FAILS: test.assertCookieAttributeDoesNotMatch value', 'absent', '', 'other'),
          test.assertCookieAttributeDoesNotMatch('FAILS: test.assertCookieAttributeDoesNotMatch Expires', 'silver', 'Expires', 'other'),
          test.assertCookieAttributeDoesNotMatch('FAILS: test.assertCookieAttributeDoesNotMatch Secure', 'silver', 'Secure', 'other'),
          test.assertCookieAttributeDoesNotMatch('FAILS: test.assertCookieAttributeDoesNotMatch HttpOnly', 'silver', 'HttpOnly', 'other'),
          test.assertCookieAttributeDoesNotMatch('FAILS: test.assertCookieAttributeDoesNotMatch SameSite', 'silver', 'SameSite', 'other'),
        */
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - attributes added',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=gold=chip%3BDomain%3D{{httpbin}}%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BPath%3D/response-headers%3BSecure%3BHttpOnly%3BSameSite%3DNone%3B%20attribute-name%20%3D%20%22attribute-value%22%3BPartionned'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeExists('test.assertCookieAttributeExists value', 'gold', ''),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Domain', 'gold', 'Domain'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Expires', 'gold', 'Expires'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Max-Age', 'gold', 'Max-Age'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Path', 'gold', 'Path'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Secure', 'gold', 'Secure'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists HttpOnly', 'gold', 'HttpOnly'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists SameSite', 'gold', 'SameSite'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists Partionned', 'gold', 'Partionned'),
        test.assertCookieAttributeExists('test.assertCookieAttributeExists attribute-name', 'gold', 'attribute-name'),

        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals value', 'gold', '', 'chip'),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Domain', 'gold', 'Domain', 'httpbin.org'),
        //Format of Expires is ISO. Value is not modified when Max-age is not provided.
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Expires', 'gold', 'Expires', '2999-01-01T01:01:00.000Z'),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Max-Age', 'gold', 'Max-Age', 0),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Path', 'gold', 'Path', '/response-headers'),
        // For attributes not in extensions and that are present without a value, this assertions matches with boolean true
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Secure', 'gold', 'Secure', true),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals HttpOnly', 'gold', 'HttpOnly', true),
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals SameSite', 'gold', 'SameSite', 'None'),
        // For attributes not in extensions and that are present without a value, this assertions matches with empty string
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals Partionned', 'gold', 'Partionned', ''),
        //For attributes in extensions, this assertion ignores bad whiste spaces before their value and double quotes surrounding it
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals attribute-name', 'gold', 'attribute-name', 'attribute-value'),

        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual value', 'gold', '', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Domain', 'gold', 'Domain', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Expires', 'gold', 'Expires', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Max-Age', 'gold', 'Max-Age', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Path', 'gold', 'Path', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Secure', 'gold', 'Secure', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual HttpOnly', 'gold', 'HttpOnly', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual SameSite', 'gold', 'SameSite', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual Partionned', 'gold', 'Partionned', 'other'),
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual attribute-name', 'gold', 'attribute-name', 'other'),

        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches value', 'gold', '', 'ch.p'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Domain', 'gold', 'Domain', '.+'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Expires', 'gold', 'Expires', '2999-01-01T01:01:00\\.000Z'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Max-Age', 'gold', 'Max-Age', '0'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Path', 'gold', 'Path', '/*'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Secure', 'gold', 'Secure', 'tr..'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches HttpOnly', 'gold', 'HttpOnly', 'tr..'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches SameSite', 'gold', 'SameSite', 'N.n.'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Partionned', 'gold', 'Partionned', '^$'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches attribute-name', 'gold', 'attribute-name', '^.ttr.b.t..v.l..$'),

        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch value', 'gold', '', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Domain', 'gold', 'Domain', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Expires', 'gold', 'Expires', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Max-Age', 'gold', 'Max-Age', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Path', 'gold', 'Path', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Secure', 'gold', 'Secure', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch HttpOnly', 'gold', 'HttpOnly', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch SameSite', 'gold', 'SameSite', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Partionned', 'gold', 'Partionned', 'other'),
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch attribute-name', 'gold', 'attribute-name', 'other'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - Value of Expires is lowered according to Max-Age',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        // Value of Expires is lowered according to Max-age when Max-Age is provided.
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Expires', 'copper', 'Expires', '.*2999.*'),
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches Max-Age', 'copper', 'Max-Age', '1'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeExists',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeExists('test.assertCookieAttributeExists value', 'silver', ''),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeDoesNotExist',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeDoesNotExist('test.assertCookieAttributeDoesNotExist value', 'absent', ''),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeEquals',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeEquals('test.assertCookieAttributeEquals value', 'silver', '', ''),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeDoesNotEqual',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeDoesNotEqual('test.assertCookieAttributeDoesNotEqual value', 'silver', '', 'other'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeMatches',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeMatches('test.assertCookieAttributeMatches value', 'silver', '', '^$'),
      ],
    },
    test.case {
      name: 'Cookie attribute assertions - assertCookieAttributeDoesNotMatch',
      request: test.GET('https://{{httpbin}}/response-headers?Set-Cookie=copper=chip%3BExpires%3DSun%2C%2001-Jan-2999%2001%3A01%3A00%20GMT%3BMax-Age%3D1'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieAttributeDoesNotMatch('test.assertCookieAttributeDoesNotMatch Expires', 'copper', 'Expires', '.*2999.*'),
      ],
    },

    test.case {
      name: 'Cookie assertions - cookies set in previous test cases are still in jar',
      request: test.GET('https://{{httpbin}}/response-headers'),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieExists('test.assertCookieExists chocolate', 'chocolate'),
        test.assertCookieExists('test.assertCookieExists silver', 'silver'),
        test.assertCookieExists('test.assertCookieExists gold', 'gold'),
        test.assertCookieExists('test.assertCookieExists copper', 'copper'),
      ],
    },
  ],
}