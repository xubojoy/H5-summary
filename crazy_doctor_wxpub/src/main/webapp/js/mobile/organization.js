$().ready(function(){
	 var imgs = $('#myCarousel');
     imgs.carousel({interval :3000});
     $(".swiper-slide").swipe({
     	swipeLeft: function (event, direction, distance, duration, fingerCount) {
       		imgs.carousel('next');
        },
       
       	swipeRight : function (event, direction, distance, duration, fingerCount) {
          	imgs.carousel('prev');
        }
     });
     
     var width = $(window).width();
     $('.banner_block .item').css('height',width/2+'px');
     $('.banner_block .banner_img').css('clip','rect(0px '+width+'px '+width/2+'px 0px)' );
     
     var successCB = function(){
    	 $('.projectTagsList li').click(function(){
    		 window.location.href= mobileUrl + '/projects?footerName=project&feature='+$(this).text()+'&organizationId='+organizationId;
    	});
     }
     ProjectsVM.fetchFeatures('projectTagsList',successCB);
})






