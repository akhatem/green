//  ###### Pagination show and hide on scroll ######
window.addEventListener("scroll", () => {
    var pagination = document.getElementById("pagination_id");
    const currentScroll = window.pageYOffset;
    if (currentScroll <= 200) {
      pagination.style.display = "none";
      return;
    }
    else{
      pagination.style.display = "block";
    }
  });

  //  ###### Pagination show and hide on scroll ######