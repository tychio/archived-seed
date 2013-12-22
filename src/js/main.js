(function() {
  requirejs.config({
    baseUrl: 'src/js/',
    paths: {
      jquery: '../lib/jquery/jquery'
    }
  });

  requirejs(['jquery'], function($) {});

}).call(this);
