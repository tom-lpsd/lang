// User extensions can be added here.
//
// Keep this file to avoid  mystifying "Invalid Character" error in IE
Selenium.prototype.getRandomString = function(cnt) {
    var result = "";
    for (var i = 0; i < cnt ; i++) {
	result += String.fromCharCode(0x3042 + Math.random()*54);
    }
    return result;
};

Selenium.prototype.doTypeRandomString = function(locator, cnt) {
    var str = this.getRandomString(cnt);
    this.doType(locator, str);
};
