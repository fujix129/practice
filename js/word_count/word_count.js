(function(){
  'use strict';

  var comment = document.getElementById('comment')
  var label = document.getElementById('label')

  var limit = 30;
  var warning = 10;

  label.innerHTML = limit;

  comment.addEventListener('keyup', function() {
    var remaining = limit - this.value.length;
    label.className = remaining < warning ? 'warning' : "";
    label.innerHTML = remaining;
  });

})();
