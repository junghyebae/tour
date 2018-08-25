<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/sliderkit-core.css" media="screen, projection">
<script type="text/javascript" src="jquery.sliderkit.1.9.2.pack.js"></script>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>

	
</head>
<body>
	
<!-- Main container -->
<div class="sliderkit">
 
    <!-- Nav container -->
    <div class="sliderkit-nav">
     
        <!-- Nav clip -->
        <div class="sliderkit-nav-clip">
            <ul>
                <li><a title="[link title]" href="#" rel="nofollow"><img src="../image/now/test.jpg"></a></li>
                <li><a title="[link title]" href="#" rel="nofollow"><img src="../image/now/test2.jpg"></a></li>
                <li><a title="[link title]" href="#" rel="nofollow"><img src="../image/now/test3.jpg"></a></li>
            </ul>
        </div>
         
        <!-- Nav buttons -->
        <div class="sliderkit-nav-btn sliderkit-nav-prev"><a title="Previous line" href="#" rel="nofollow"><span>Previous line</span></a></div>
        <div class="sliderkit-nav-btn sliderkit-nav-next"><a title="Next line" href="#" rel="nofollow"><span>Next line</span></a></div>
     
    </div><!-- // end of Nav container -->
     
    <!-- Panels container -->
    <div class="sliderkit-panels">   
     
        <!-- Go buttons -->
        <div class="sliderkit-go-btn sliderkit-go-prev"><a title="Previous" href="#" rel="nofollow"><img src="../image/btn_mainbanner_prev.gif" alt="이전" /></a></div>
        <div class="sliderkit-go-btn sliderkit-go-next"><a title="Next" href="#" rel="nofollow"><img src="../image/btn_mainbanner_next.gif" alt="이전" /></a></div>
        
        <!-- <div class="sliderkit-btn sliderkit-go-btn sliderkit-go-prev"><a href="#"><img src="../image/btn_mainbanner_prev.gif" alt="이전" /></a></div>
		<div class="sliderkit-btn sliderkit-go-btn sliderkit-go-next"><a href="#"><img src="../image/btn_mainbanner_next.gif" alt="이전" /></a></div> -->
 
        <!-- Panel divs -->
        <div class="sliderkit-panel">
            ~content
        </div>
        
        <div class="sliderkit-panel">
            ~content
        </div>
        
        <div class="sliderkit-panel">
            ~content
 
            <!-- Place caption textbox here if needed -->
            <div class="sliderkit-panel-textbox">
                <div class="sliderkit-panel-text">
                    <h4>Caption title</h4>
                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</p>
                </div>
                <div class="sliderkit-panel-overlay"></div>
            </div>
 
        </div>
         
    </div><!-- // end of Panels container -->
     
</div><!-- // end of Main container -->


	
	







<script type="text/javascript">
$(window).load(function(){
    $(".photoslider-1click").sliderkit({
        auto:false,
        circular:true,
        panelclick:true,
        //panelfx:"sliding",
        panelfx:"fading",
        panelfxspeed:1000,
        panelfxeasing:"easeInOutExpo"
    });
});
</script>




</body>
</html>