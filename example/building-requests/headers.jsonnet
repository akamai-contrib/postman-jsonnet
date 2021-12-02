local test = import '../../postman.libsonnet';

test.suite {
  name: 'Adding Headers',

  item: [
    test.case {
      name: 'Adding Headers',
      request: test.GET('https://{{httpbin}}/anything') +
               test.header('Captain', 'America') +
               test.header('Incredible', 'Hulk'),
    },

    test.case {
      name: 'Adding Headers From An Object',
      request: test.GET('https://{{httpbin}}/anything') +
               test.header({
                 'X-Small-Guitar': 'Ukulele',
                 'X-Thing': 'foo',
               }),
    },
  ],
}
