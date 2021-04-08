var password = document.getElementById("password");
var confirm_password = document.getElementById("password2");
var x = document.getElementById("submit2");
x.setAttribute('onsubmit', 'event.preventDefault();');

function validatePassword() {
	if (password.value != confirm_password.value) {
		console.log("passwords don't match");
		x.setAttribute('onsubmit', 'event.preventDefault();');
		confirm_password.setCustomValidity("Passwords Don't Match");
	} else {
		x.setAttribute('onsubmit', 'console.log(\'hello\');');
		console.log("passwords match");
		confirm_password.setCustomValidity('');
	}
}

password.onkeyup = function() {
	validatePassword();
};
confirm_password.onkeyup = function() {
	validatePassword()
};