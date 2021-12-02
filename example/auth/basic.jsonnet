local test = import '../../postman.libsonnet';

// in this example, we hardcode the credentials;
// in real life, you should instead use Postman variables, e.g.:
//
//   local credentials = { user: '{{user}}', password: '{{password}}' };
//
// and then, pass them on the command line:
//
//  newman run --env-var user=ynohat --env-var password=secret suite.json
local credentials = { user: 'ynohat', password: 'secret' };
local basicAuth = test.auth.basic(user=credentials.user, password=credentials.password);
local b64 = std.base64('%(user)s:%(password)s' % credentials);

test.suite {
  name: 'Auth',

  item: [

    // basic auth can be added at the case level, in which case it applies only to that case
    test.case {
      name: 'Authenticating case',
      request: test.GET('https://{{httpbin}}/headers')
               + basicAuth,
      tests: [
        test.assertBodyMatches('test.assertBodyMatches(credentials base64)', b64),
      ],
    },

    // basic auth can also be added at the suite level, in which case it
    // should be applied to all requests in the collection
    test.suite + basicAuth + {
      name: 'Basic Auth',
      item: [
        test.case {
          name: 'Case in authenticating suite',
          request: test.GET('https://{{httpbin}}/headers'),
          tests: [
            test.assertBodyMatches('test.assertBodyMatches(credentials base64)', b64),
          ],
        },

        test.case {
          name: 'Case in authenticating suite without auth',
          request: test.GET('https://{{httpbin}}/headers')
                   + test.auth.noauth(),
          tests: [
            test.assertBodyDoesNotMatch('test.assertBodyMatches(credentials base64)', b64),
          ],
        },
      ],
    },
  ],
}
