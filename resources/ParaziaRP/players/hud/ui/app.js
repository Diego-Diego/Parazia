$(function() {
    $('#shield-icon').hide();
    $('.shield-progress').hide();
    $('.setting-box').hide();
  window.addEventListener('message', function(event) {
      var data = event.data;
      if (data.action == 'updateHud') {
        $('body').fadeIn();
        $('.value-food').css('height', event.data.bouf + '%');
        $('.value-water').css('height', event.data.soif + '%');
        $('.value-health').css('height', event.data.health + '%');
        $('.value-shield').css('height', event.data.armour + '%');
        $('.player-id').html(event.data.id);
        //   $('.player-count').html(event.data.playerCount);
        $('.job').html(event.data.job);
        $('.orga').html(event.data.job2);
        $('.player-money').html(event.data.liquide);
        $('.player-black').html(event.data.sale);

      };
      if (data.action == 'updateVoice') {
          if (event.data.talking == true) {
              $('.micro-icon').fadeOut();
              $('.micro-icon2').fadeIn();
          } else {
              $('.micro-icon2').fadeOut();
              $('.micro-icon').fadeIn();
          }
      }
      if (data.action == 'setShield') {
        if (data.status == true) {
            $('.container-prog').css("width", "133px")
            $('.container-prog').css("left", "19.5%")

            $('.player-box').css("left", "23.5%")
            $('.id-box').css("left", "23.5%")
            $('.micro-back').css("left", "23.5%")

            $('.food-progress').css("left", "-35%")
            $('#food-icon').css("left", "-35.2%")

            $('.water-progress').css("left", "-11%")
            $('#water-icon').css("left", "-11.2%")

            $('.health-progress').css("left", "13%")
            $('#health-icon').css("left", "13.2%")
            $('#shield-icon').fadeIn(1000);
            $('.shield-progress').fadeIn(1000);
        } else {
            $('#shield-icon').fadeOut(400);
            $('.shield-progress').fadeOut(400);
            $('.container-prog').css("width", "100px")
            $('.container-prog').css("left", "19%")

            $('.player-box').css("left", "22%")
            $('.id-box').css("left", "22%")
            $('.micro-back').css("left", "22%")

            $('.food-progress').css("left", "-29%")
            $('#food-icon').css("left", "-29.5%")

            $('.water-progress').css("left", "1%")
            $('#water-icon').css("left", "1.5%")

            $('.health-progress').css("left", "31%")
            $('#health-icon').css("left", "31.5%")
        }
    };

    if (data.action == 'setHudMenu') {
        $('.setting-box').fadeIn(400);
    };
  });
})

// $('#player-btn2').click(function() {
//     $('.player-box').fadeOut(400);
// })

// $('#player-btn').click(function() {
//     $('.player-box').fadeIn(400);
// })

$('#id-btn2').click(function() {
    $('.id-box').fadeOut(400);
})

$('#id-btn').click(function() {
    $('.id-box').fadeIn(400);
})

$('#micro-btn2').click(function() {
    $('.micro-back').fadeOut(400);
})

$('#micro-btn').click(function() {
    $('.micro-back').fadeIn(400);
})

$('#vital-btn2').click(function() {
    $('.container-prog').fadeOut(400);
})

$('#vital-btn').click(function() {
    $('.container-prog').fadeIn(400);
})

$('#job-btn2').click(function() {
    $('.job-box').fadeOut(400);
})

$('#job-btn').click(function() {
    $('.job-box').fadeIn(400);
})

$('#money-btn2').click(function() {
    $('.money-box').fadeOut(400);
})

$('#money-btn').click(function() {
    $('.money-box').fadeIn(400);
})

$('#close-btn').click(function() {
    $.post('https://ParaziaRP/close', JSON.stringify({}))
    $('.setting-box').fadeOut(400);
})