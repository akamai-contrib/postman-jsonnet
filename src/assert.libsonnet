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

  /*
  hostOnly and session are not an attribute 
  in https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie 
  or https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12

  GET https://httpbin.akam.cloud/response-headers?Set-Cookie=silver%3D
  yields 
  - Set-Cookie: silver=
  - JSON.stringify(cookie): {"name":"silver","expires":null,"maxAge":0,"domain":"httpbin.akam.cloud","path":"/","secure":false,"httpOnly":false,"hostOnly":true}
  */
  assertCookieAttributeExists(title,name,attribute):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).to.equal("Attribute found true");
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
  }),
  assertCookieAttributeDoesNotExist(title,name,attribute):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).not.to.equal("Attribute found true");
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
  }),
  assertCookieAttributeEquals(title,name,attribute,value):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            attributeValue=cookie.value;
            if(attributeValue === undefined){
              attributeValue="";
            }
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            attributeValue=cookie.domain;
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeValue=cookie.expires.toISOString();
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            attributeValue=cookie.maxAge;
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            attributeValue=cookie.path;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
                //match() catpures the part of the string that matches followed by all captured groups.
                //slice() keeps only the captured groups
                //join() joins them in a single string
                attributeValue=extension.match(regex).slice(1).join("");
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).to.equal("Attribute found true");
        pm.expect(attributeValue).to.equal(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
    value: value,
  }),
  assertCookieAttributeDoesNotEqual(title,name,attribute,value):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            attributeValue=cookie.value;
            if(attributeValue === undefined){
              attributeValue="";
            }
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            attributeValue=cookie.domain;
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeValue=cookie.expires.toISOString();
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            attributeValue=cookie.maxAge;
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            attributeValue=cookie.path;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
                //match() catpures the part of the string that matches followed by all captured groups.
                //slice() keeps only the captured groups
                //join() joins them in a single string
                attributeValue=extension.match(regex).slice(1).join("");
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).to.equal("Attribute found true");
        pm.expect(attributeValue).to.not.eql(params.value);
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
    value: value,
  }),
  assertCookieAttributeMatches(title,name,attribute,regex):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            attributeValue=cookie.value;
            if(attributeValue === undefined){
              attributeValue="";
            }
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            attributeValue=cookie.domain;
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeValue=cookie.expires.toISOString();
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            attributeValue=cookie.maxAge;
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            attributeValue=cookie.path;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
                //match() catpures the part of the string that matches followed by all captured groups.
                //slice() keeps only the captured groups
                //join() joins them in a single string
                attributeValue=extension.match(regex).slice(1).join("");
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).to.equal("Attribute found true");
        pm.expect(attributeValue).to.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
    regex: regex,
  }),
  assertCookieAttributeDoesNotMatch(title,name,attribute,regex):: |||
    (function (params) {
      let attributeValue;
      // Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
      let attributeFound=false;
      const cookie=pm.cookies.one(params.name);
      //console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
      if (cookie){
        switch(params.attribute) {
          // Cookie value
          case "":
            attributeFound=true; 
            // Defaults to undefined when it's empty in the Set-Cookie header
            attributeValue=cookie.value;
            if(attributeValue === undefined){
              attributeValue="";
            }
            break;
          case "Domain":
            attributeFound=true;
            // Defaults to hostname in request when not provided in the Set-Cookie header
            attributeValue=cookie.domain;
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue=cookie.expires;
            if (attributeValue){
              attributeValue=cookie.expires.toISOString();
              attributeFound=true;
            }
            break;
          case "Max-Age":
            attributeFound=true;
            // Defaults to 0 when not provided in the Set-Cookie header
            attributeValue=cookie.maxAge;
            break;
          case "Path":
            attributeFound=true;
            // Defaults to / when not provided in the Set-Cookie header
            attributeValue=cookie.path;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.secure;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue=cookie.httpOnly;
            if (attributeValue){
              attributeFound=true;
            }
            break;
          // Partitioned // Returns a boolean (no value expected for this attribute)
          // SameSite
          default:
            if (cookie.extensions){
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %%x21 / %%x23-2B / %%x2D-3A / %%x3C-5B / %%x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                 Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                 Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\\t)*${params.attribute}(?: |\\t)*(?:=(?: |\\t)*(?:(?:\"(.*)\")|(.*)))?$`);
              extension = cookie.extensions.find(item => regex.test(item));
              if (extension){
                attributeFound=true;
                //match() catpures the part of the string that matches followed by all captured groups.
                //slice() keeps only the captured groups
                //join() joins them in a single string
                attributeValue=extension.match(regex).slice(1).join("");
              }
            }
            break;
        }
      }
      pm.test(params.title, function () {
        pm.expect("Attribute found " + attributeFound).to.equal("Attribute found true");
        pm.expect(attributeValue).to.not.match(new RegExp(params.regex));
      });
    })(%s);
  ||| % std.manifestJson({
    title: title,
    name: name,
    attribute: attribute,
    regex: regex,
  }),
}
