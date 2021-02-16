# Postman Jsonnet

Provides a library for generating Postman collections using Jsonnet.

These collections can then be imported into Postman UI, or directly run using the `newman` command-line runner.

The purpose is to simplify maintaining tests alongside configuration data, both as Jsonnet.

An example collection is provided within [`example/main.jsonnet`](./example/main.jsonnet). For now, this is the best
source of documentation.

## Dependencies

You will need:

* [`go-jsonnet`](https://github.com/google/go-jsonnet) (to render your tests to Postman/Newman JSON)
* [`newman`](https://www.npmjs.com/package/newman) (if you wish to run tests from the command line)
* [`postman`](https://www.postman.com/) (if you wish to import/run your tests in the UI)

## Installing

Whichever installation method you choose, we assume that you have a project directory, and that
you will install within `vendor/postman-jsonnet`.

### From git

```
git clone https://github.com/akamai-contrib/postman-jsonnet vendor/postman-jsonnet
```

### jsonnet-bundler (experimental)

```bash
jb install https://github.com/akamai-contrib/postman-jsonnet@main
```

> Specifying the `@main` branch is necessary, this repository has [eschewed oppressive terminology](https://tools.ietf.org/id/draft-knodel-terminology-00.html) 💯.

## Simple Usage
### Creating a test suite

You can use the following as a basis:

```
// Use this to have basic Postman/HTTP test functionality
local test = import 'postman-jsonnet/postman.libsonnet';

// Use the following instead if you wish to have Akamai specific test functionality included
// local test = import 'postman-jsonnet/akamai.libsonnet';

test.suite {
  name: "Postman Quickstart",

  item: [
    test.case {
      name: "Simple GET Test",
      request: test.GET("https://httpbin.org/anything"),
      tests: [
        test.assertStatusCodeIsOneOf("It works", [200])
      ]
    }
  ]
}
```

Store this in a simple test file with a jsonnet extension, for example: `postman-quickstart.jsonnet`.

### Rendering the test suite

You will now render the Jsonnet file to a JSON file, and it is good practice to store the output
in a separate folder. This command will store the output in a folder called `postman` (`-o`),
creating it if required (`-c`). It will also add the `vendor` folder to the library search path,
without which the `import 'postman-jsonnet/postman.libsonnet';` statement will fail.

```bash
jsonnet -J vendor -co postman/postman-quickstart.json postman-quickstart.jsonnet
```

### Executing the test suite

If you have installed `newman`, you can run:

```
newman run postman/postman-quickstart.json
newman

Testing with Jsonnet quickstart

→ Postman Quickstart
  GET https://httpbin.org/anything [200 OK, 725B, 649ms]
  ✓  It works

┌─────────────────────────┬────────────────────┬───────────────────┐
│                         │           executed │            failed │
├─────────────────────────┼────────────────────┼───────────────────┤
│              iterations │                  1 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│                requests │                  1 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│            test-scripts │                  3 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│      prerequest-scripts │                  2 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│              assertions │                  1 │                 0 │
├─────────────────────────┴────────────────────┴───────────────────┤
│ total run duration: 718ms                                        │
├──────────────────────────────────────────────────────────────────┤
│ total data received: 495B (approx)                               │
├──────────────────────────────────────────────────────────────────┤
│ average response time: 649ms [min: 649ms, max: 649ms, s.d.: 0µs] │
└──────────────────────────────────────────────────────────────────┘
```

Of course, you can also import the generated JSON into Postman.

## Running the example

You will need access to the Internet, specifically to `httpbin.org`.

```bash
cd vendor/postman-jsonnet
jsonnet -co build/example.json example/main.jsonnet
newman run build/example.json
```
