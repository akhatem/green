$(document).on('turbolinks:load', function(){
  window.addEventListener("scroll", () => {
    var footer = document.getElementById("footer_id");
    const currentScroll = window.pageYOffset;
    console.log("current scroll: ", currentScroll);
    // console.log(document.body.classList[0]);
    window_h = window.screen.availHeight;
    console.log("window height: ", window_h);
    if (currentScroll == window_h) {
      footer.style.display = "none";
      return;
    }
    else{
      footer.style.display = "block";
    }
  });
});