local test = import '../../postman.libsonnet';

test.suite {
  name: 'Header Assertions',

  item: [
    test.case {
      name: 'Header assertions',
      request: test.GET('https://{{httpbin}}/response-headers?X-Wing=gold'),
      tests: [
        test.assertHeaderExists('test.assertHeaderExists', 'X-Wing'),
        test.assertHeaderDoesNotExist('test.assertHeaderDoesNotExist', 'Tie-Fighter'),
        test.assertHeaderEquals('test.assertHeaderEquals', 'X-Wing', 'gold'),
        test.assertHeaderDoesNotEqual('test.assertHeaderDoesNotEqual', 'X-Wing', 'wobble'),
        test.assertHeaderMatches('test.assertHeaderMatches', 'X-Wing', 'g.ld'),
        test.assertHeaderDoesNotMatch('test.assertHeaderDoesNotMatch', 'X-Wing', 's.lver'),
      ],
    },
  ],
}
