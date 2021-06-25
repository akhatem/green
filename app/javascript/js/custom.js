//  ###### Pagination show and hide on scroll ######
// $(document).ready(function (){
//   // alert(document.body.classList[0]);
//   window_h = window.screen.availHeight;
//   window.addEventListener("scroll", (event) => {
//     if (document.body.classList[0] != "static_pages" && document.body.classList[1] === "index"){
//       event.preventDefault();
//       var pagination = document.getElementById("pagination_id");
//       const currentScroll = window.pageYOffset;
//       if (currentScroll <= windows_h - 200) {
//         pagination.style.display = "none";
//         return;
//       }
//       else{
//         pagination.style.display = "block";
//       }
//     }
//   }); 
// });
//  ###### Pagination show and hide on scroll ######

// ###### Handle message disapearance ######

$(document).on('turbolinks:load', function(){
  // if (document.body.classList[0] === "static_pages"){
  //   $(".notice").hide();
  //   $(".alert").hide();
  // }
  
  // if (document.body.classList[0] != "static_pages" && document.body.classList[1] === "index"){
    $(".notice").delay(2000).slideUp(250);
  // }

  // if (document.body.classList[0] != "static_pages" && document.body.classList[1] === "index"){
    $(".alert").delay(2000).slideUp(250);
  // }
});
// ###### Handle message disapearance ######

