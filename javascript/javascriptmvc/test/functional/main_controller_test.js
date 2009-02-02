new Test.Controller('main',{
   test_helloworld: function() {
      // check that Hello World has been written
      this.assert_equal('Hello World', document.getElementById('hello').innerHTML);
   }
});
