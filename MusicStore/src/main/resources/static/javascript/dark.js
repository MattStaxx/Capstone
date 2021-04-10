function myFunction() {
			var element = document.body;
			var thList = document.getElementsByTagName("th");
			var tdList = document.getElementsByTagName("td");
			var i;
			element.classList.toggle("dark");
			for(i = 0; i < thList.length; i++) {
				thList[i].classList.toggle("dark2");
			};
			for(i = 0; i < tdList.length; i++) {
				tdList[i].classList.toggle("dark2");
			}
		}