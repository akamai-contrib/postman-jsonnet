utils = {
  /**
   * Returns value of attribute named attribute in cookie named name
   * Or undefined if attribute or cookie are not found
	 * 
	 * hostOnly and session are not an attribute 
   * in https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie 
   * or https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-rfc6265bis-12
   *
   * GET https://httpbin.akam.cloud/response-headers?Set-Cookie=silver%3D
   * yields 
   * - Set-Cookie: silver=
   * - JSON.stringify(cookie): {"name":"silver","expires":null,"maxAge":0,"domain":"httpbin.akam.cloud","path":"/","secure":false,"httpOnly":false,"hostOnly":true}
   */
  getCookieAttributeValue(name, attribute) {
		let attributeValue;
		// Becomes true if cookie has been set in the cookie jar and (attribute always exists even its value is empty (cookie value), attribute is provided or attribute has a default value)
		let attributeFound=false;
		const cookie=pm.cookies.one(name);
		//console.log("JSON.stringify(pm.cookies.toObject(): <" + JSON.stringify(pm.cookies.toObject()) + ">");
		if (cookie){
			switch(attribute) {
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
		if (!attributeFound){
			attributeValue=undefined;
		}
		return attributeValue;
	},
};