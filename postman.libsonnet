// SPOOFING TO STAGING
//
// Directly spoofing in Postman/Newman is not possible. Options include editing hosts file,
// and using Charles.
// To use with Charles, quite simple:
//
// HTTPS_PROXY=127.0.0.1:8888 newman run -k collection.json
// -k : insecure (don't check cert)
//
// SKIPPING TESTS
//
// Not really practical for the time being, tracked here:
// https://github.com/postmanlabs/postman-app-support/issues/8929
//
// SCRIPTING
//
// https://learning.postman.com/docs/sending-requests/variables/#defining-variables-in-scripts
// Set a local, temporary variable
// pm.variables.set("variable_key", "variable_value");
// Set a global variable
// pm.globals.set("variable_key", "variable_value");
// Set an environment variable
// pm.environment.set("variable_key", "variable_value");
//
// Using dynamic variables (cache buster, random color, bank card number, guid, etc...)
// https://learning.postman.com/docs/sending-requests/variables/#using-dynamic-variables

(import './src/suite.libsonnet') +
(import './src/case.libsonnet') +
(import './src/request.libsonnet') +
(import './src/assert.libsonnet') +
(import './src/utils.libsonnet') +
(import './src/auth.libsonnet')
