(function(){
  'use strict';

  var btn = document.getElementById('btn');

  btn.addEventListener('click', function() {
    var unsei = ["大吉","中吉","小吉","吉","凶"];
    var today = unsei[Math.floor( Math.random() * unsei.length)];
    this.textContent = today;
  });
  btn.addEventListener('mousedown', function() {
    this.className = "pushed";
  });
  btn.addEventListener('mouseup', function() {
    this.className = "";
  });

})();
