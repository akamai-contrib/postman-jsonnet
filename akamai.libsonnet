(import './postman.libsonnet') + {
  pragma:: {
    local _pragma(v) = $.header('Pragma', v),

    getCacheTags: _pragma('akamai-x-get-cache-tags'),
    getRequestId: _pragma('akamai-x-get-request-id'),
    cacheOn: _pragma('akamai-x-cache-on'),
    cacheRemoteOn: _pragma('akamai-x-cache-remote-on'),
    checkCacheable: _pragma('akamai-x-check-cacheable'),
    getCacheKey: _pragma('akamai-x-get-cache-key'),
    getExtractedValues: _pragma('akamai-x-get-extracted-values'),
    getNonces: _pragma('akamai-x-get-nonces'),
    getSslClientSessionId: _pragma('akamai-x-get-ssl-client-session-id'),
    getTrueCacheKey: _pragma('akamai-x-get-true-cache-key'),
    serialNo: _pragma('akamai-x-serial-no'),
    tapiocaTrace: _pragma('akamai-x-tapioca-trace'),

    all:: std.foldl(function(a, b) a + b, std.objectValues(self), {}),
    caching:: std.foldl(function(a, b) a + b, [
      self.getCacheTags,
      self.checkCacheable,
      self.cacheOn,
      self.cacheRemoteOn,
      self.getCacheKey,
      self.getTrueCacheKey,
    ], {}),
  },

  suite+:: {
    pre+: [
      importstr './src/akamai.js',
    ],
  },

  assertExtractedValueExists(title, name):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        pm.expect(values).to.exist;
        pm.expect(values).to.have.property(params.name);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
  }),

  assertExtractedValueDoesNotExist(title, name):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        if (values) {
          pm.expect(values).to.not.have.key(params.name);
        }
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
  }),

  assertExtractedValueEquals(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        pm.expect(values).to.exist;
        pm.expect(values[params.name]).to.equal(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),

  assertExtractedValueDoesNotEqual(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        if (values) {
          pm.expect(values[params.name]).to.not.equal(params.value);
        }
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),

  assertExtractedValueIsOneOf(title, name, values):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        pm.expect(values).to.exist;
        pm.expect(values[params.name]).to.be.oneOf(params.values);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    values: values,
  }),

  assertExtractedValueIsNotOneOf(title, name, values):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        if (values) {
          pm.expect(values[params.name]).to.not.be.oneOf(params.values);
        }
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    values: values,
  }),

  assertExtractedValueMatches(title, name, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        pm.expect(values).to.exist;
        pm.expect(values[params.name]).to.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    regex: regex,
  }),

  assertExtractedValueDoesNotMatch(title, name, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        let values = akamai.extractedValues(pm.response);
        if (values) {
          pm.expect(values[params.name]).to.not.match(new RegExp(params.regex));
        }
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    regex: regex,
  }),
}
