local test = import '../../postman.libsonnet';

// In this example, we hardcode the credentials because passing for convenience and clarity;
// In real life, you should use the default constructor:
//
//   local auth = test.auth.basic();
//
// This will set the credentials to '{{user}}', '{{password}}'
// which will allow you to then pass them as variables:
//
//  newman run --env-var user=xyz --env-var password=xyz suite.json
local credentials = { user: 'ynohat', password: 'secret' };
local basicAuth = test.auth.basic(user=credentials.user, password=credentials.password);
local b64 = std.base64('%(user)s:%(password)s' % credentials);

test.suite {
  name: 'Basic Auth',

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
            test.assertBodyDoesNotMatch('test.assertBodyDoesNotMatch(credentials base64)', b64),
          ],
        },
      ],
    },
  ],
}
