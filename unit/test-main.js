/**
/* The test-main.js for unit testing by Requirejs and Jasmine.
/* according to the ../build/javascript/main.js changing require configurition.
/* Tychio [code@tychio.net]
**/
var tests = [];
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/Spec\.js$/.test(file)) {
      tests.push(file);
    }
  }
}
requirejs.config({
    baseUrl: '/base/build/javascript/',
    paths: {
    },
    deps: tests,
    callback: window.__karma__.start
});