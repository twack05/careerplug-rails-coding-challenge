$(document).ready(function() {
    $('.comment-form').hide();
    $('.comment-btn').on('click', function() {
      $('.comment-form').hide();
      $(this).next('.comment-form').show();
    });

    $('.submit').on('click', function() {
      var id = $(this).attr('id'),
          author = $(this).attr('data');
          text = $(this).prev('.comment-text').val();

      $.ajax({
        type: 'POST',
        url: '/jobs/'+ id +'/comments',
        data: {comment: {author: author, text: text, job_id: id}},
        success: function(data) {
          $('.'+ data.job_id + '').append("<div class='comment'><p>"+ data.author + "</p><p class='comment-text'>" + data.text +"</p></div>");
          $('.comment-form').val('');
          $('.comment-form').hide();
          return false;
        },
        error: function(data) {
          console.log(data);
          return false;
        }
      });
    });
  });
