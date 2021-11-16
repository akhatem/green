$(document).on('turbolinks:load', function(){
    // if (document.body.classList[0] != "static_pages" && document.body.classList[1] === "index"){ }
    // if (top.location.pathname != "//sign_in"){ }
    if (document.body.classList[1] != "new" && document.body.classList[1] != "edit" && 
      document.body.classList[1] != "update" && document.body.classList[1] != "create"){
      $(".notice").delay(5000).slideUp(250);
      $(".alert").delay(5000).slideUp(250);
    }
    if(document.body.classList[0] != "cashier_pages"){
      $(".notice").delay(10000).slideUp(250);
      $(".alert").delay(10000).slideUp(250);
    }

    // Disable Submit Buttons On Click.
    $('input[type=submit]').on("click", function() {
      $(this).attr("disabled", true);
      $(this).val("processing..");
      $(this).parents('form').submit();
    })
});