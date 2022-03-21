// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery
//= require jquery_ujs

/*
    heart tweet
*/
$(document).on("click", ".like_tweet:not('.text-danger')", function(e){
    $(this).addClass("text-danger");
    var tweet_id = this.getAttribute("tweet");
    var user_id = this.getAttribute("user");
    // increment likes count
    var likes_html = $(".hearts-"+tweet_id).html();
    var likes_count = likes_html.match(/\d+/)[0];
    var word = "Like";
    if (likes_count == 1)
    {   
        word += "s";
    }

    $(".hearts-"+tweet_id).html((parseInt(likes_count)+1).toString() + " " + word);

    if (user_id == -1)
    {
        return window.location.replace("users/sign_in");
    }
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
          
        url:'/tweets/'+tweet_id+'/likes',
        type:'POST',
        dataType:'json',
        processData: false,
        data: JSON.stringify({
            tweet_id: tweet_id,
            user_id: user_id,
         }),
        success:function(data){
            
        },
        error:function(data){
            console.log(data);
        }
    });


    e.preventDefault();
});

/*
    unheart tweet
*/
$(document).on("click", ".like_tweet.text-danger", function(e){
    $(this).removeClass("text-danger");
    var tweet_id = this.getAttribute("tweet");
    var user_id = this.getAttribute("user");
    var like_id = this.getAttribute("like");
    var likes_html = $(".hearts-"+tweet_id).html();
    var likes_count = likes_html.match(/\d+/)[0];
    var word = "Like";
    if (likes_count == 1)
    {   
        word += "s";
    }

    $(".hearts-"+tweet_id).html((parseInt(likes_count)-1).toString() + " " + word);

    if (user_id == -1)
    {
        return window.location.replace("users/sign_in");
    }
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
          
        url:'/tweets/'+tweet_id+'/likes/'+ like_id,
        type:'DELETE',
        dataType:'json',
        processData: false,
        data: JSON.stringify({
            like_id: like_id
         }),
        success:function(data){
            
        },
        error:function(data){
            console.log(data);
        }
    });


    e.preventDefault();
});

/*
    follow profile
*/
$(document).on("click", ".follow-profile.btn-primary", function(e){

    var f = this.getAttribute("follow");
    var u = this.getAttribute("user_id");
    $(this).addClass("btn-outline-primary");
    $(this).removeClass("btn-primary");
    $(this).text("Unfollow");
    $(".number").html(parseInt($(".number").html(), 10)+1);
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
          
        url:'/follow',
        type:'POST',
        dataType:'json',
        processData: false,
        data: JSON.stringify({
            user_id: u,
            follow: f
         }),
        success:function(data){

        },
        error:function(data){
            console.log(data);
        }
    });


    e.preventDefault();
});
/*
    unfollow profile
*/
$(document).on("click", ".follow-profile.btn-outline-primary", function(e){
    var f = this.getAttribute("follow");
    var u = this.getAttribute("user_id");
    $(this).removeClass("btn-outline-primary");
    $(this).addClass("btn-primary");
    $(this).text("Follow");
    $(".number").html(parseInt($(".number").html(), 10)-1);
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
        
        url:'/follow',
        type:'DELETE',
        dataType:'json',
        processData: false,
        data: JSON.stringify({
            user_id: u,
            follow: f
         }),
        success:function(data){
            console.log(data);
        },
        error:function(data){
            console.log(data);
        }
    });


    e.preventDefault();
});