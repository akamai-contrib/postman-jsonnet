local test = import '../../postman.libsonnet';

// In this example, we hardcode the credentials because passing for convenience and clarity;
// In real life, you should use the default constructor:
//
//   local auth = test.auth.edgegrid();
//
// This will set the credentials to '{{clientSecret}}', '{{clientToken}}', '{{authToken}}',
// which will allow you to then pass them as variables:
//
//  newman run --env-var clientSecret=xyz --env-var clientToken=xyz --env-var accessToken=xyz suite.json
local edgegridAuth = test.auth.edgegrid(
  clientSecret='fake_client_secret',
  clientToken='fake_client_token',
  accessToken='fake_access_token',
);

local edgegridAuthzRegex = '"Authorization": "EG1-HMAC-SHA256 client_token=.*;access_token=.*;timestamp=.*;nonce=.*;signature=.*"';
local assertHasEdgegridAuthz = test.assertBodyMatches('test.assertBodyMatches(edgegrid authz)', edgegridAuthzRegex);
local assertDoesNotHaveEdgegridAuthz = test.assertBodyDoesNotMatch('test.assertBodyDoesNotMatch(edgegrid authz)', edgegridAuthzRegex);

test.suite {
  name: 'Edgegrid Auth',

  item: [

    // can be added at the case level, in which case it applies only to that case
    test.case {
      name: 'Authenticating case',
      request: test.GET('https://{{httpbin}}/headers')
               + edgegridAuth,
      tests: [
        assertHasEdgegridAuthz,
      ],
    },

    // basic auth can also be added at the suite level, in which case it
    // should be applied to all requests in the collection
    test.suite + edgegridAuth + {
      name: 'Authenticating suite',
      item: [
        test.case {
          name: 'Case in authenticating suite',
          request: test.GET('https://{{httpbin}}/headers'),
          tests: [
            assertHasEdgegridAuthz,
          ],
        },

        test.case {
          name: 'Case in authenticating suite without auth',
          request: test.GET('https://{{httpbin}}/headers')
                   + test.auth.noauth(),
          tests: [
            assertDoesNotHaveEdgegridAuthz,
          ],
        },
      ],
    },
  ],
}
