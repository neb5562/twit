// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery
//= require jquery_ujs


$(document).on("click", ".like_tweet", function(e){
    $(this).addClass("text-danger");
    // increment likes count
    var tweet_id = this.getAttribute("tweet");
    var user_id = this.getAttribute("user");
    if (user_id == -1)
    {
        return window.location.replace("users/sign_in");
    }
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
          
        url:'/likes',
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


$(document).on("click", ".like_tweet.text-danger", function(e){
    $(this).removeClass("text-danger");
    var tweet_id = this.getAttribute("tweet");
    var user_id = this.getAttribute("user");
    var like_id = this.getAttribute("like");
    if (user_id == -1)
    {
        return window.location.replace("users/sign_in");
    }
    $.ajax({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
            'Content-Type': 'application/json'
          },
          
        url:'/likes/'+ like_id,
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
