{
  utils:: {
    escapeString(str, excludedChars=[])::
      local allowedChars = '0123456789abcdefghijklmnopqrstuvwqxyzABCDEFGHIJKLMNOPQRSTUVWQXYZ';
      local utf8(char) = std.foldl(function(a, b) a + '%%%02X' % b, std.encodeUTF8(char), '');
      local escapeChar(char) = if std.member(excludedChars, char) || std.member(allowedChars, char) then char else utf8(char);
      std.join('', std.map(escapeChar, std.stringChars(str))),

    encodeQuery(params, separator='&')::
      local fmtParam(p) = if params[p] != true
        then '%s=%s' % [self.escapeString(p), self.escapeString(params[p])]
        else '%s' % [self.escapeString(p)];
      std.join(separator, std.map(fmtParam, std.objectFields(params))), 
  },
}
