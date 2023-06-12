$(document).ready(function(){
    // LUA listener
    window.addEventListener('message', function( event ) {
        if (event.data.action == 'open') {
            var type        = event.data.type;
            var userData    = event.data.array['user'][0];
            var licenseData = event.data.array['licenses'];
            var sex = userData.sex;
            
            if ( type == 'driver' || type == null) {
                $('img').show();
                $('#name').css('color', '#282828');
  
                if (type == null) {
                    $('#height').text(userData.height);
                }

                if ( sex.toLowerCase() == 'm' ) {
                    $('img').attr('src', 'assets/images/male.png');
                    $('#sex').text('male');
                } else {
                    $('img').attr('src', 'assets/images/female.png');
                    $('#sex').text('female');
                }
  
                $('#name').text(userData.firstname + ' ' + userData.lastname);
                $('#dob').text(userData.dateofbirth + " ans");
                $('#signature').text(userData.firstname + ' ' + userData.lastname);
        
                if ( type == 'driver' ) {
                    if ( licenseData != null ) {
                        Object.keys(licenseData).forEach(function(key) {
                            var type = licenseData[key];

                            if ( key == 'motor' && type ) {
                                type = 'moto';
                            } else if ( key == 'heavycar' && type ) {
                                type = 'camion';
                            } else if ( key == 'car' && type ) {
                                type = 'voiture';
                            }

                            if ( type == 'moto' || type == 'camion' || type == 'voiture' ) {
                                $('#licenses').append('<p>'+ type +'</p>');
                            }
                        });
                    }
                    $('#id-card').css('background', 'url(assets/images/license.png)');
                } else {
                    $('#id-card').css('background', 'url(assets/images/idcard.png)');
                }
            } else if ( type == 'arms' ) {
                if ( sex.toLowerCase() == 'm' ) {
                    $('img').attr('src', 'assets/images/male.png');
                    $('#sex').text('male');
                } else {
                    $('img').attr('src', 'assets/images/female.png');
                    $('#sex').text('female');
                }
                $('#name').text(userData.firstname + ' ' + userData.lastname);
                $('#dob').text(userData.dateofbirth + " ans");
                $('#signature').text(userData.firstname + ' ' + userData.lastname);

                if ( licenseData != null ) {
                    Object.keys(licenseData).forEach(function(key) {
                        var type = licenseData[key];
                        if ( key == 'weapon' && type ) {
                            type = 'PPA 1';
                        } else if ( key == 'weapon2' && type ) {
                            type = 'PPA 2';
                        } else if ( key == 'weapon3' && type ) {
                            type = 'PPA 3';
                        } else if ( key == 'weapon4' && type ) {
                            type = 'PPA 4';
                        }
    
                        if ( type == 'PPA 1' || type == 'PPA 2' || type == 'PPA 3' || type == 'PPA 4' ) {
                            $('#licenses').append('<p>'+ type +'</p>');
                        }
                    });
                }

                $('#id-card').css('background', 'url(assets/images/firearm.png)');
            }

            $('#id-card').show();
        } else if (event.data.action == 'close') {
            $('#name').text('');
            $('#dob').text('');
            $('#height').text('');
            $('#signature').text('');
            $('#sex').text('');
            $('#id-card').hide();
            $('#licenses').html('');
        }
    });
});