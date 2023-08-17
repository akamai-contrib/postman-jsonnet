utils = {
  /**
   * Returns value of attribute named attribute in cookie named name
   * Or undefined if attribute or cookie are not found
   * 
   * Some attributes have default value even if they are not specified explicitely in the Set-Cookie response header
   * For exampe, 
   *  Set-Cookie: silver=
   * yields:
   * 
   *   Expires: null
   *   Max-Age: 0
   *   Domain: 'httpbin.org' -> hostname of the request that returned Set-Cookie
   *   Path: '/'
   *   Secure: false
   *   HttpOnly: false
   * 
   * @param  cookies Cookie list (type CookieList, see https://www.postmanlabs.com/postman-collection/CookieList.htm )
   * @param  name Name of the cookie
   * @param  attribute Name of the attribute (see https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12)
   * @return  Value of the attribute (mixed type), or undefined if cookie or attribute is not found
   */
  getCookieAttributeValue(cookies, name, attribute) {
    let attributeValue;
    if (cookies) {
      const cookie = cookies.one(name);
      //console.log("JSON.stringify(cookies.toObject(): <" + JSON.stringify(cookies.toObject()) + ">");
      if (cookie) {
        //console.log("JSON.stringify(cookie: <" + JSON.stringify(cookie) + ">");
        switch (attribute) {
          case "Domain":
            // Defaults to hostname in request when not provided in the Set-Cookie header
            attributeValue = cookie.domain;
            break;
          case "Expires":
            // Defaults to null when not provided in the Set-Cookie header
            attributeValue = cookie.expires;
            if (attributeValue) {
              attributeValue = cookie.expires.toUTCString();
            }
            break;
          case "Max-Age":
            // Defaults to 0 when not provided in the Set-Cookie header
            attributeValue = cookie.maxAge;
            break;
          case "Path":
            // Defaults to / when not provided in the Set-Cookie header
            attributeValue = cookie.path;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "Secure":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue = cookie.secure;
            break;
          // Returns a boolean (no value expected for this attribute);
          case "HttpOnly":
            // Defaults to false when not provided in the Set-Cookie header
            attributeValue = cookie.httpOnly;
            break;
          // extensions include custom attributes
          // and Partitioned, which returns a boolean (no value expected for this attribute)
          // and SameSite
          default:
            if (cookie.extensions) {
              /* https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12#section-4.1.1-2
                cookie-pair       = cookie-name BWS "=" BWS cookie-value
                cookie-name       = 1*cookie-octet
                cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
                cookie-octet      = %x21 / %x23-2B / %x2D-3A / %x3C-5B / %x5D-7E
                            ; US-ASCII characters excluding CTLs,
                            ; whitespace DQUOTE, comma, semicolon,
                            ; and backslash
              */
              /* Accepts (and ignores) bad with spaces and (BWS) and optional double quotes surrounding value
                Capture 2 groups, with attribute value in 1st group (if it's surrounded by double quotes) or the 2nd group (if it's not)
                Both groups can't match at same time. The other one is undefined
              */
              const regex = new RegExp(`^(?: |\t)*${attribute}(?: |\t)*(?:=(?: |\t)*(?:(?:"(.*)")|(.*)))?$`);
              const extension = cookie.extensions.find(item => regex.test(item));
              if (extension) {
                //match() catpures the part of the string that matches followed by all captured groups.
                //slice() keeps only the captured groups
                //join() joins them in a single string
                attributeValue = extension.match(regex).slice(1).join("");
              }
            }
            break;
        }
      }
    }
    return attributeValue;
  },
};