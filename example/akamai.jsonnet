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
        ],
      }) + test.pragma.getExtractedValues,
      tests: [
        test.assertExtractedValueExists('test.assertExtractedValueExists', 'RO_ENABLED'),
        test.assertExtractedValueExists('test.assertExtractedValueExists', 'AKA_PM_CACHEABLE_OBJECT'),
        test.assertExtractedValueDoesNotExist('test.assertExtractedValueDoesNotExist', 'FAKE_VARIABLE'),
        test.assertExtractedValueEquals('test.assertExtractedValueEquals', 'RO_ENABLED', 'false'),
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
  ],
}
