$(function() {
  $(".campaign-image").click(function(){
    $(".img-thumbnail").removeClass("img-selected");
    $("#campaign_image").val(this.id);
    $(this).children("img").addClass("img-selected");
  });

  function setCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "")  + expires + "; path=/";
  }

  function getCookie(name) {
      var nameEQ = name + "=";
      var ca = document.cookie.split(';');
      for(var i=0;i < ca.length;i++) {
          var c = ca[i];
          while (c.charAt(0)==' ') c = c.substring(1,c.length);
          if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
      }
      return null;
  }

  $('.first-payment.close').click(function(){
    setCookie('first-payment', true, 365);
  });

  if(!getCookie('first-payment')){
    $('.first-payment-row').show();
  }

});