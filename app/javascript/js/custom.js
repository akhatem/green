//  ###### Pagination show and hide on scroll ######
window.addEventListener("scroll", (event) => {
    event.preventDefault();
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

  //  ###### Brand and Category dependent dropdown list  ######


  //  ###### Brand and Category dependent dropdown list  ######