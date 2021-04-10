function myFunction() {
			var element = document.body;
			element.classList.toggle("dark");
		}

var element = document.getElementById("footer");
var rect = element.getBoundingClientRect();
var w = window.innerWidth;
var h = window.innerHeight;

// console.log(rect.top, rect.bottom);
// console.log(w + " " + h);
if (rect.bottom <= h) {
	element.style = "position: fixed; bottom: 0; width:100%";
}
//// console.log(x);
rect = element.getBoundingClientRect();
// console.log(rect.top, rect.bottom);
// console.log(w + " " + h);
var count = 0;
window.onresize = reportWindowSize;
function reportWindowSize() {
	// console.log("hi");
	count++;
	element.style = "position:width:100%";
	if (count != 1) {
		rect = element.getBoundingClientRect();
		h = window.innerHeight;
		// console.log(rect.bottom + " " + h);
		if (rect.bottom <= h) {
			element.style = "position: fixed; bottom: 0; width:100%";
		} else {
			element.style = "position:width:100%";
		}
	}
}