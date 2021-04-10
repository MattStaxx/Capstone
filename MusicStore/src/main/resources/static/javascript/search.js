var search1 = document.getElementById("search1");
var xx = document.getElementById("options1");
var x2 = document.getElementById("search2");
var xx2 = document.getElementById("options2");
var y = document.getElementById("divId1");

var count = 0;
var count2 = 0;

var currentState = false;
var currentState2 = false;

var option1A = document.getElementById("options1");

option1A.addEventListener("change", function() {
	if (this.value == "price") {
		y.removeChild(search1);
		xx2.selectedIndex = "6";
		y.appendChild(x2);
	}
});
var option1B = document.getElementById("options2");
option1B.addEventListener("change", function() {
	// console.log(this.value);
	if (this.value != "price") {
		y.removeChild(x2);
		if (this.value == "artist") {
			xx.selectedIndex = "0";
		} else if (this.value == "format") {
			xx.selectedIndex = "1";
		} else if (this.value == "genre") {
			xx.selectedIndex = "2";
		} else if (this.value == "style") {
			xx.selectedIndex = "3";
		} else if (this.value == "title") {
			xx.selectedIndex = "4";
		} else if (this.value == "category") {
			xx.selectedIndex = "5";
		}
		y.appendChild(search1);
	}
});

y.removeChild(x2);
x2.removeAttribute("hidden");
