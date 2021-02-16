local test = import '../../postman.libsonnet';

test.suite {
  name: 'Response Body Assertions',

  item: [
    test.case {
      name: 'Response Body Assertions',
      request: test.POST('https://httpbin.org/anything') +
              test.body.raw('hello!'),
      tests: [
        test.assertBodyMatches('test.assertBodyMatches', 'hello'),
        test.assertBodyDoesNotMatch('test.assertBodyDoesNotMatch', 'iggityzaggetyzoom'),
      ],
    },
  ],
}