local test = import '../../postman.libsonnet';

test.suite {
  name: 'Status Code Assertions',

  item: [
    test.case {
      name: 'Status Code assertions',

      request: test.GET('https://{{httpbin}}/status/200'),

      tests: [
        test.assertStatusCodeEquals('test.assertStatusCodeEquals', 200),
        test.assertStatusCodeDoesNotEqual('test.assertStatusCodeDoesNotEqual', 500),
        test.assertStatusCodeIsOneOf('test.assertStatusCodeIsOneOf', [200, 500]),
        test.assertStatusCodeIsNotOneOf('test.assertStatusCodeIsNotOneOf', [418, 718]),
        // range inclusive at both ends
        test.assertStatusCodeIsWithin('test.assertStatusCodeIsWithin', 100, 200),
        test.assertStatusCodeIsNotWithin('test.assertStatusCodeIsWithin', 100, 199),
        // also works, but creates very big JSON, so avoid
        test.assertStatusCodeIsOneOf('test.assertStatusCodeIsOneOf (std.range)', std.range(100, 200)),
      ],
    },
  ],
}
