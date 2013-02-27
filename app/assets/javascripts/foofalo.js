function toggle(divclass, element, speed) {
     $(divclass).each(function(index) {
          if ($(this).attr("id") == element) {
               $(this).toggle(speed);
          }
     });
}

// function toggle(element) {
//      $('.jokedetails').each(function(index) {
//           if ($(this).attr("id") == element) {
//                $(this).toggle(200);
//           }
//      });
// }

// function toggle(element) {
//      $('.jokedetails').each(function(index) {
//           if ($(this).attr("id") == element) {
//                $(this).show(200);
//           }
//           else {
//                $(this).hide(600);
//           }
//      });
// }

// function toggle(element){
// 	alert(element);
// 	  // $(element).toggle(speed);
// }
// function toggle(element, speed){
// 	  $(element).toggle(speed);
// }
// $(document).ready(function(){
//   $("#first").click(function() {
// 	  $("#div1").toggle();	
//   })
// 
//   $("#second").click(function() {
// 	  $("#div2").toggle();	
//   })
// });
