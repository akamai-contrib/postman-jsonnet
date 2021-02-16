{
  assertHeaderExists(title, header):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.response.to.have.header(params.header);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
  }),

  assertHeaderDoesNotExist(title, header):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.response.to.not.have.header(params.header);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
  }),

  assertHeaderEquals(title, header, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.headers.get(params.header)).to.equal(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
    value: value,
  }),

  assertHeaderDoesNotEqual(title, header, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.headers.get(params.header)).to.not.eql(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
    value: value,
  }),

  assertHeaderMatches(title, header, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.headers.get(params.header)).to.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
    regex: regex,
  }),

  assertHeaderDoesNotMatch(title, header, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.headers.get(params.header)).to.not.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    header: header,
    regex: regex,
  }),

  assertStatusCodeEquals(title, statusCode):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.equal(params.statusCode);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    statusCode: statusCode,
  }),

  assertStatusCodeDoesNotEqual(title, statusCode):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.not.equal(params.statusCode);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    statusCode: statusCode,
  }),

  assertStatusCodeIsOneOf(title, statusCodes):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.be.oneOf(params.statusCodes);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    statusCodes: statusCodes,
  }),

  assertStatusCodeIsNotOneOf(title, statusCodes):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.not.be.oneOf(params.statusCodes);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    statusCodes: statusCodes,
  }),

  assertStatusCodeIsWithin(title, start, end):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.be.within(params.start, params.end);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    start: start,
    end: end,
  }),

  assertStatusCodeIsNotWithin(title, start, end):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.code).to.not.be.within(params.start, params.end);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    start: start,
    end: end,
  }),

  assertBodyMatches(title, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.text()).to.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    regex: regex,
  }),

  assertBodyDoesNotMatch(title, regex):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.response.text()).to.not.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    regex: regex,
  }),

  assertCookieExists(title, name):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.has(params.name)).to.be.true;
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
  }),

  assertCookieDoesNotExist(title, name):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.has(params.name)).to.not.be.true;
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
  }),

  assertCookieEquals(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.get(params.name)).to.equal(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),

  assertCookieDoesNotEqual(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.get(params.name)).to.not.equal(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),

  assertCookieMatches(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.get(params.name)).to.match(new RegExp(params.value));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),


  assertCookieDoesNotMatch(title, name, value):: |||
    (function (params) {
      pm.test(params.title, function () {
        pm.expect(pm.cookies.get(params.name)).to.not.match(new RegExp(params.value));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    value: value,
  }),
}
