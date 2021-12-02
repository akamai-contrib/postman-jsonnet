local test = import '../../postman.libsonnet';

test.suite {
  name: 'Setting Cookies',

  item: [
    test.case {
      name: 'Adding Cookies',
      request: test.GET('https://{{httpbin}}/anything') +
               test.cookie('chocolate', 'chip') +
               test.cookie('turkish', 'delight'),
    },

    test.case {
      name: 'Combined',
      request: test.GET('https://{{httpbin}}/anything') +
               test.header('X-Small-Guitar', 'Ukulele') +
               test.header('X-Thing', 'foo') +
               test.cookie('chocolate', 'chip') +
               test.cookie('turkish', 'delight'),
    },
  ],
}
