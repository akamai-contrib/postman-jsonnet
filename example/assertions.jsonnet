local test = import "../postman.libsonnet";

test.suite {
  name: "Assertions",

  item: [
    test.case {
      name: "Header assertions",
      request: test.GET("https://httpbin.org/response-headers?X-Wing=gold"),
      tests: [
        test.assertHeaderExists("test.assertHeaderExists", "X-Wing"),
        test.assertHeaderDoesNotExist("test.assertHeaderDoesNotExist", "Tie-Fighter"),
        test.assertHeaderEquals("test.assertHeaderEquals", "X-Wing", "gold"),
        test.assertHeaderDoesNotEqual("test.assertHeaderDoesNotEqual", "X-Wing", "wobble"),
        test.assertHeaderMatches("test.assertHeaderMatches", "X-Wing", "g.ld"),
        test.assertHeaderDoesNotMatch("test.assertHeaderDoesNotMatch", "X-Wing", "s.lver"),
      ],
    },

    test.case {
      name: "Cookie assertions",
      request: test.GET("https://httpbin.org/response-headers?Set-Cookie=chocolate%3Dchip"),

      // by default, we disable cookies; if we need to work with them, set this to false
      disableCookies: false,

      tests: [
        test.assertCookieExists("test.assertCookieExists", "chocolate"),
        test.assertCookieDoesNotExist("test.assertCookieDoesNotExist", "caramel"),
        test.assertCookieEquals("test.assertCookieEquals", "chocolate", "chip"),
        test.assertCookieMatches("test.assertCookieMatches", "chocolate", "ch.p"),
        test.assertCookieDoesNotMatch("test.assertCookieDoesNotMatch", "chocolate", "ch.t"),
      ],
    },
  ],
}
