local test = import '../akamai.libsonnet';

test.suite {
  name: 'Akamai',

  item: [
    test.case {
      name: 'Extracted Values - key and value',
      request: test.GET({
        protocol: 'https',
        host: 'httpbin.org',
        path: '/response-headers',
        query: [
          { key: 'x-akamai-session-info', value: 'name=RO_ENABLED; value=false' },
          { key: 'x-akamai-session-info', value: 'name=AKA_PM_CACHEABLE_OBJECT; value=true' },
          { key: 'x-akamai-session-info', value: 'name=PMUSER_EXTRACTED_1; value=key1=value1; key2=value2; full_location_id=Name1; separator=%s' % test.utils.escapeString('%3d') },
          { key: 'x-akamai-session-info', value: 'name=PMUSER_EXTRACTED_2; value=key3=value3; key4=value4; full_location_id=Name2' },
          
        ],
      }) + test.pragma.getExtractedValues,
      tests: [
        test.assertExtractedValueExists('test.assertExtractedValueExists', 'RO_ENABLED'),
        test.assertExtractedValueExists('test.assertExtractedValueExists', 'AKA_PM_CACHEABLE_OBJECT'),
        test.assertExtractedValueDoesNotExist('test.assertExtractedValueDoesNotExist', 'FAKE_VARIABLE'),
        test.assertExtractedValueEquals('test.assertExtractedValueEquals', 'RO_ENABLED', 'false'),
        test.assertExtractedValueEquals('test.assertExtractedValueEquals with full_location_id', 'PMUSER_EXTRACTED_1', 'key1=value1; key2=value2'),
        test.assertExtractedValueEquals('test.assertExtractedValueEquals with full_location_id and separator', 'PMUSER_EXTRACTED_2', 'key3=value3; key4=value4'),
        test.assertExtractedValueDoesNotEqual('test.assertExtractedValueDoesNotEqual', 'RO_ENABLED', 'true'),
        test.assertExtractedValueMatches('test.assertExtractedValueMatches', 'RO_ENABLED', 'f.lse'),
        test.assertExtractedValueDoesNotMatch('test.assertExtractedValueDoesNotMatch', 'RO_ENABLED', 'tr.e'),
        test.assertExtractedValueIsOneOf('test.assertExtractedValueIsOneOf', 'RO_ENABLED', ['true', 'false']),
        test.assertExtractedValueIsNotOneOf('test.assertExtractedValueIsNotOneOf', 'RO_ENABLED', ['maybe', 'truly']),
      ],
    },

    test.case {
      name: 'Cache Key', // and other debug headers in general
      request: test.GET({
        protocol: 'https',
        host: 'httpbin.org',
        path: '/response-headers',
        query: [
          { key: 'x-cache-key', value: 'S/L/1234/678909/365d/org.example.com/style.css cid=///RO_ENCODING=br' },
        ],
      }) + test.pragma.getCacheKey, // see the list in akamai.libsonnet
      tests: [
        // currently, this is how to test Akamai debug headers
        // TODO: maybe add specialised assertions for well-known pragma response headers
        test.assertHeaderMatches('test.cacheKey.serial', 'x-cache-key', '/1234/'),
        test.assertHeaderMatches('test.cacheKey.cpcode', 'x-cache-key', '/678909/'),
        test.assertHeaderMatches('test.cacheKey.ttl', 'x-cache-key', '/365d/'),
      ],
    },

    // This test shows how an EdgeAuth token can be generated as part of a test suite
    // to test endpoints that use this auth method.
    test.case {
      name: 'EdgeAuth',
      request: test.GET('https://httpbin.org/anything'),
      tests:: [
        |||
          var edgeAuth = new akamai.EdgeAuth({
            // key to use, should be a hex string (required)
            key: '02af42',

            // time when the token becomes valid, unix timestamp or e.g. "now+20"
            startTime: 25,

            // validity window in seconds, relative to startTime (required if endTime is not specified)
            windowSeconds: 60,
            // expiry timestamp (required if windowSeconds is not specified)
            endTime: 1228448335

            // "sha256" or "sha1" or "md5" (optional, default=sha256)
            // algorithm: "sha256",

            // (optional string)
            // salt: null,

            // client IP for which the token is valid (optional string)
            // ip: null,

            // data payload (optional string)
            // payload: null,

            // session id for which the token is valid (optional string, opaque)
            // sessionId: null,

            // (optional, string)
            // fieldDelimiter: '~',

            // (optional, string)
            // aclDelimiter: '!'),

            // true to generate legacy 2.0 tokens, not 2.0.1 (optional, bool)
            // escapeEarly: false,
          });

          pm.test("URL Token matches expected value", function () {
            var token = edgeAuth.generateURLToken("/abc");
            pm.expect(token).to.equal("st=25~exp=1228448335~hmac=f1c0082ed694eaa39b4f64474a3c9910fde6ea3002be98618cce6dc77f48efcb");
          });

          pm.test("ACL Token matches expected value", function () {
            var token = edgeAuth.generateACLToken("/abc/*");
            pm.expect(token).to.equal("st=25~exp=1228448335~acl=/abc/*~hmac=9ce101383873df73b1030f056c884bd4d4a30cacf262e83443e0b965f1a56f6e");
          });

          pm.test("Multi ACL Token matches expected value", function () {
            var token = edgeAuth.generateACLToken(["/abc/*", "/foo/bar"]);
            pm.expect(token).to.equal("st=25~exp=1228448335~acl=/abc/*!/foo/bar~hmac=8587df49bfab711a9f63025c5030d70082a2111dcf86a21b29aa325780c0c1b2");
          });
        |||
      ],
    }
  ],
}
