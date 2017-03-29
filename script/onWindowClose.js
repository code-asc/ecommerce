window.onbeforeunload = function (event) {
    var message = 'You are about to close the browser window';
    if (typeof event == 'undefined') {
        event = window.event;
    }
    if (event) {
      $.ajax({
        url:"removeSession.cfc?method=onWindowClose",
      })
    }

};

$(function () {
    $("a, button, input[type='submit']").click(function () {
        window.onbeforeunload = null;
    });
});
