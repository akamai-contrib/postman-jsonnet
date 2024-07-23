function createHmac(algo, key) {
  switch (algo) {
    case 'sha256':
      return CryptoJS.algo.HMAC.create(CryptoJS.algo.SHA256, key);
    case 'sha1':
      return CryptoJS.algo.HMAC.create(CryptoJS.algo.SHA1, key);
    case 'md5':
      return CryptoJS.algo.HMAC.create(CryptoJS.algo.MD5, key);
  }
  throw new Error('HMAC algorithm should be sha256 or sha1 or md5');
}

class EdgeAuth {
  constructor(options) {
    this.options = options

    if (!this.options.tokenName) {
      this.options.tokenName = '__token__'
    }

    if (!this.options.key) {
      throw new Error('key must be provided to generate a token.')
    }

    if (this.options.algorithm === undefined) {
      this.options.algorithm = 'sha256'
    }

    if (this.options.escapeEarly === undefined) {
      this.options.escapeEarly = false
    }

    if (!this.options.fieldDelimiter) {
      this.options.fieldDelimiter = '~'
    }

    if (!this.options.aclDelimiter) {
      this.options.aclDelimiter = '!'
    }

    if (this.options.verbose === undefined) {
      this.options.verbose = false
    }
  }

  _escapeEarly(text) {
    if (this.options.escapeEarly) {
      text = encodeURIComponent(text)
        .replace(/[~'*]/g,
          function (c) {
            return '%' + c.charCodeAt(0).toString(16)
          }
        )
      var pattern = /%../g
      text = text.replace(pattern, function (match) {
        return match.toLowerCase()
      })
    }
    return text
  }

  _generateToken(path, isUrl) {
    var startTime = this.options.startTime
    var endTime = this.options.endTime

    if (typeof startTime === 'string' && startTime.toLowerCase() === 'now') {
      startTime = parseInt(Date.now() / 1000)
    } else if (startTime) {
      if (typeof startTime === 'number' && startTime <= 0) {
        throw new Error('startTime must be number ( > 0 ) or "now"')
      }
    }

    if (typeof endTime === 'number' && endTime <= 0) {
      throw new Error('endTime must be number ( > 0 )')
    }

    if (typeof this.options.windowSeconds === 'number' && this.options.windowSeconds <= 0) {
      throw new Error('windowSeconds must be number( > 0 )')
    }

    if (!endTime) {
      if (this.options.windowSeconds) {
        if (!startTime) {
          startTime = parseInt(Date.now() / 1000)
        }
        endTime = parseInt(startTime) + parseInt(this.options.windowSeconds)
      } else {
        throw new Error('You must provide endTime or windowSeconds')
      }
    }

    if (startTime && (endTime < startTime)) {
      throw new Error('Token will have already expired')
    }

    if (this.options.verbose) {
      console.log("Akamai Token Generation Parameters")

      if (isUrl) {
        console.log("    URL         : " + path)
      } else {
        console.log("    ACL         : " + path)
      }

      console.log("    Token Type      : " + this.options.tokenType)
      console.log("    Token Name      : " + this.options.tokenName)
      console.log("    Key/Secret      : " + this.options.key)
      console.log("    Algo            : " + this.options.algorithm)
      console.log("    Salt            : " + this.options.salt)
      console.log("    IP              : " + this.options.ip)
      console.log("    Payload         : " + this.options.payload)
      console.log("    Session ID      : " + this.options.sessionId)
      console.log("    Start Time      : " + startTime)
      console.log("    Window(seconds) : " + this.options.windowSeconds)
      console.log("    End Time        : " + endTime)
      console.log("    Field Delimiter : " + this.options.fieldDelimiter)
      console.log("    ACL Delimiter   : " + this.options.aclDelimiter)
      console.log("    Escape Early    : " + this.options.escapeEarly)
    }

    var hashSource = []
    var newToken = []

    if (this.options.ip) {
      newToken.push("ip=" + this._escapeEarly(this.options.ip))
    }

    if (this.options.startTime) {
      newToken.push("st=" + startTime)
    }
    newToken.push("exp=" + endTime)

    if (!isUrl) {
      newToken.push("acl=" + path)
    }

    if (this.options.sessionId) {
      newToken.push("id=" + this._escapeEarly(this.options.sessionId))
    }

    if (this.options.payload) {
      newToken.push("data=" + this._escapeEarly(this.options.payload))
    }

    hashSource = newToken.slice()

    if (isUrl) {
      hashSource.push("url=" + this._escapeEarly(path))
    }

    if (this.options.salt) {
      hashSource.push("salt=" + this.options.salt)
    }

    this.options.algorithm = this.options.algorithm.toString().toLowerCase()
    var hmac = createHmac(
      this.options.algorithm,
      CryptoJS.enc.Hex.parse(this.options.key),
    )

    hmac.update(hashSource.join(this.options.fieldDelimiter))
    newToken.push("hmac=" + hmac.finalize())

    return newToken.join(this.options.fieldDelimiter)
  }

  generateACLToken(acl) {
    if (!acl) {
      throw new Error('You must provide acl')
    } else if (acl.constructor == Array) {
      acl = acl.join(this.options.aclDelimiter)
    }

    return this._generateToken(acl, false)
  }

  generateURLToken(url) {
    if (!url) {
      throw new Error('You must provide url')
    }
    return this._generateToken(url, true)
  }
}


/**
 * Return all values of the given response header as an Array.
 *
 * Postman does not yet have a simple API for retrieving multiple-instance response
 * headers without a workaround:
 * https://github.com/postmanlabs/postman-app-support/issues/6143
 */
function getResponseHeaderValues(response, name) {
  return response.headers
    .filter(function (header) { return String(header.key).toLowerCase() === name; })
    .map(function (header) { return header.valueOf(); });
}

akamai = {
  /**
   * Parse and return the values of x-akamai-session-info values from the response,
   * as an object.
   */
  extractedValues(response) {
    let pat = /^name=([^\s]*); value=(.*?)(?:; full_location_id=[^;]*(?:; separator=[^;]*)?)?$/;
    return getResponseHeaderValues(response, "x-akamai-session-info")
      .reduce(function (vars, value) {
        if (pat.test(value)) {
          let [res, k, v] = value.match(pat);
          vars[k] = v;
        }
        return vars;
      }, {});
  },

  EdgeAuth: EdgeAuth,
};