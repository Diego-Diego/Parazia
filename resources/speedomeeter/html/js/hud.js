var s_playerID;
var s_Rpm = 0.0;
var s_Speed;
var s_Gear;
var s_IL;
var s_Acceleration;
var s_Handbrake;
var s_LS_r;
var s_LS_o;
var s_LS_h;
var CalcSpeed;
var speedText = '';
var inVehicle = false;
var o_rpm;
var hasFilter = false;
var OverLoadRPM = false;
var IsOverLoad = false;

$(function() {
	
    window.addEventListener("message", function(event) {
        var item = event.data;
        
        if (item.ShowHud) {
			
			inVehicle      = true;
			s_PlayerID     = item.PlayerID;
			s_Rpm          = item.CurrentCarRPM;
			s_Speed        = item.CurrentCarSpeed;
			s_Kmh          = item.CurrentCarKmh;
			s_Mph          = item.CurrentCarMph;
			s_Gear         = item.CurrentCarGear;
			s_IL           = item.CurrentCarIL;
			s_Acceleration = item.CurrentCarAcceleration;
			s_Handbrake    = item.CurrentCarHandbrake;
			s_ABS          = item.CurrentCarABS;
			s_LS_r         = item.CurrentCarLS_r;
			s_LS_o         = item.CurrentCarLS_o;
			s_LS_h         = item.CurrentCarLS_h;
			CalcSpeed      = s_Kmh;
			CalcRpm        = (s_Rpm * 9);
			fuel 		   = item.CurrentCarFuel;
			
			if(CalcSpeed > 999) {
				CalcSpeed = 999;
			}

			if (fuel) {
				setProgressFuel(fuel, '.surfuel');
			}

			// console.log(item.clignotantGauche);
			// console.log(item.clignotantDroite);
			// console.log(item.lock);

			if(item.clignotantGauche == true){
				// console.log('clignotant gauche');

				$('#clignotant-gauche').addClass('active-indicator');
			}
			if(item.clignotantGauche == false){
				// console.log('clignotant gauche');

				$('#clignotant-gauche').removeClass('active-indicator');
			}
			if(item.clignotantDroite == true){
				// console.log('clignotant gauche');

				$('#clignotant-droite').addClass('active-indicator');
			}
			if(item.clignotantDroite == false){
				// console.log('clignotant gauche');

				$('#clignotant-droite').removeClass('active-indicator');
			}

			if(item.lock == false){
				$('#lock').removeClass('active-indicator');
			}
			
			if(item.lock == true){
				$('#lock').addClass('active-indicator');
			}
			
			// Vehicle speed display
			if(CalcSpeed >= 100) {
				var tmpSpeed = Math.floor(CalcSpeed) + '';
				speedText = '<span class="gray">' + tmpSpeed.substr(0, 1) + '</span><span class="gray">' + tmpSpeed.substr(1, 1) + '</span><span class="gray">' + tmpSpeed.substr(2, 1) + '</span>';
			} else if(CalcSpeed >= 10 && CalcSpeed < 100) {
				var tmpSpeed = Math.floor(CalcSpeed) + '';
				speedText = '<span class="gray">0</span><span class="gray">' + tmpSpeed.substr(0, 1) + '</span><span class="gray">' + tmpSpeed.substr(1, 1) + '</span>';
			} else if(CalcSpeed > 0 && CalcSpeed < 10) {
				speedText = '<span class="gray">0</span><span class="gray">0</span><span class="gray">' + Math.floor(CalcSpeed) + '</span>';
			} else {
				speedText = '<span class="gray">0</span><span class="gray">0</span><span class="gray">0</span>';
			}

			const Kilometrage      = item.kilometrage;

			if(Kilometrage >= 10000) {
				var kmage = Math.floor(Kilometrage) + '';
				kmElement = '<div class="mdt">' + kmage.substr(0, 1) + '</div> <div class="mdt">' + kmage.substr(1, 1) + '</div> <div class="mdt">' + kmage.substr(2, 1) + '</div> <div class="mdt">' + kmage.substr(3, 1) + '</div> <div style="border-right: none;" class="mdt">' + kmage.substr(4, 1) + '</div>';
			} else if(Kilometrage >= 1000 && Kilometrage < 10000) {
				var kmage = Math.floor(Kilometrage) + '';
				kmElement = '<div class="mdt">0</div> <div class="mdt">' + kmage.substr(0, 1) + '</div> <div class="mdt">' + kmage.substr(1, 1) + '</div> <div class="mdt">' + kmage.substr(2, 1) + '</div> <div style="border-right: none;" class="mdt">' + kmage.substr(3, 1) + '</div>';
			} else if(Kilometrage >= 100 && Kilometrage < 1000) {
				var kmage = Math.floor(Kilometrage) + '';
				kmElement = '<div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">' + kmage.substr(0, 1) + '</div> <div class="mdt">' + kmage.substr(1, 1) + '</div> <div style="border-right: none;" class="mdt">' + kmage.substr(2, 1) + '</div>';
			} else if(Kilometrage >= 10 && Kilometrage < 100) {
				var kmage = Math.floor(Kilometrage) + '';
				kmElement = '<div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">' + kmage.substr(0, 1) + '</div> <div style="border-right: none;" class="mdt">' + kmage.substr(1, 1) + '</div>';
			} else if(Kilometrage > 0 && Kilometrage < 10) {
				kmElement = '<div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">0</div> <div style="border-right: none;" class="mdt">' + Math.floor(Kilometrage) + '</div>';
			} else {
				kmElement = '<div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">0</div> <div class="mdt">0</div> <div style="border-right: none;" class="mdt">0</div>';
			}

			$(".cdt").html(kmElement);
			
			// Display speed and container
			setProgressSpeed(CalcSpeed / 1.50,'.progress-speed');
			$(".speeddisplay").html(speedText);
			$("#container").fadeIn(500);


		

			
        } else if (item.HideHud) {
			
			// Hide GUI
			$("#container").fadeOut(500);
			inVehicle = false;
        }
    });


	function setProgressFuel(percent, element){
		document.querySelector(element).style.width = percent + "%";
	  }
	
	  // Speed
	  function setProgressSpeed(value, element){
		var circle = document.querySelector(element);
		var radius = circle.r.baseVal.value;
		var circumference = radius * 2 * Math.PI;
		var html = $(element).parent().parent().find('span');
		var percent = value*100/220;
	
		circle.style.strokeDasharray = `${circumference} ${circumference}`;
		circle.style.strokeDashoffset = `${circumference}`;
	
		const offset = circumference - ((-percent*73)/100) / 100 * circumference;
		circle.style.strokeDashoffset = -offset;
	
		html.text(value);
	}
});
