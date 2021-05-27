window.addEventListener("scroll", () => {
    var footer = document.getElementById("footer_id");
    const currentScroll = window.pageYOffset;
    if (currentScroll <= 120) {
      footer.style.display = "none";
      return;
    }
    else{
      footer.style.display = "block";
    }
  });