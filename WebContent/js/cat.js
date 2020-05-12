    $(document).ready(function(){
        $(".nav-middle").hover(function(){
            $(".nav-bottom").addClass("hover");
        },function(){
            $(".nav-bottom").removeClass("hover");
        })
        $(".bottom-left").hover(function(){
            $(".nav-bottom").addClass("hover");
        },function(){
            $(".nav-bottom").removeClass("hover");
        })
        $(".bottom-right").hover(function(){
            $(".nav-bottom").addClass("hover");
        },function(){
            $(".nav-bottom").removeClass("hover");
        })
        // 네비 오버시 아래로 내려오는것 -----------------------
        $(".nav-bottom .nav-middle li").hover(function(){
            var i = $(".nav-bottom .nav-middle li").index(this);
            $(".nav-top .nav-middle li").eq(i).find("a").addClass("hover");
        },function(){
            $(".nav-top .nav-middle li a").removeClass("hover");
        })
        // nav-bottom 오버시 nav-top 부분 변화 -------------------
        
    })