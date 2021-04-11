function myFunction() {
			var element = document.body;
			var thList = document.getElementsByTagName("th");
			var tdList = document.getElementsByTagName("td");
			var footer = document.getElementsByTagName("footer");
			var i;
			
			element.classList.toggle("dark");
			for(i = 0; i < thList.length; i++) {
				thList[i].classList.toggle("dark2");
			};
			for(i = 0; i < tdList.length; i++) {
				tdList[i].classList.toggle("dark2");
			}
			for(i = 0; i < footer.length; i++) {
				footer[i].classList.toggle("dark2");
			}
			console.log(liList)[0];
		}
		
var thList = document.getElementsByTagName("th");
var tdList = document.getElementsByTagName("td");
var footer = document.getElementsByTagName("footer");
var i;
const btn = document.querySelector(".btn-toggle");
const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");
console.log(prefersDarkScheme);
const currentTheme = localStorage.getItem("theme");
console.log(currentTheme);
if (currentTheme == "dark") {
	document.body.classList.toggle("dark");
		for(i = 0; i < thList.length; i++) {
			thList[i].classList.toggle("dark2");
		};
		for(i = 0; i < tdList.length; i++) {
			tdList[i].classList.toggle("dark2");
		}
		for(i = 0; i < footer.length; i++) {
			footer[i].classList.toggle("dark2");
		}
		} else if (currentTheme == "light") {
			document.body.classList.toggle("light-mode");
		}

btn.addEventListener("click", function() {
	if (prefersDarkScheme.matches) {
		document.body.classList.toggle("light-mode");
		var theme = document.body.classList.contains("light-mode") ? "light" : "dark";
	} else {
		document.body.classList.toggle("dark-mode");
		var theme = document.body.classList.contains("dark-mode") ? "dark" : "light";
	}
	localStorage.setItem("theme", theme);
});
