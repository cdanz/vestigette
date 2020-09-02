"use strict";

let mode = null;
let panel = null;
let editMode = null;
let pctRE = /pct\d+\_\d/;
let genericTotalClicks = 0;
let genericClickArr = [];

/*
Capitalize a given str.
*/
function capitalize(str) {
	return str.charAt(0).toUpperCase() + str.slice(1);
}


/*
Return pctX_Y from element's classList.
*/
function getPct(element) {
	let pctmatch = element.className.match(pctRE);
	return pctmatch[0];
}

/*
Return multidimensional array with number of clicks pushed to end of row that already includes percents, el gives position of el to perform on
*/
function pctToClicks(arr, el) { 
	let min = 100;
	let limit = arr.length;
	let i;
	let splitBy = 1;
	let commonMultiplier;
	let isMultiple = true;
	let number;
	let whole;
	let leftover;
	let clickNum;
	for (i = 0; i < limit; i++) {
		if (parseFloat(arr[i][el]) < min) {
			min = parseFloat(arr[i][el]);
		}
	}
	do {
		commonMultiplier = min / splitBy;
		isMultiple = true;
		for (i = 0; i < limit; i++) {
			if (arr[i][el]) {
				number = parseFloat(arr[i][el]) / commonMultiplier;
				whole = Math.round(number);
				leftover = Math.abs(number - whole);
				if (leftover > 0.0001) {
					isMultiple = false;	
				}
			}
		}
		splitBy++;
	} while (!isMultiple);
	for (i = 0; i < limit; i++) {
		if (arr[i][el]) {
			clickNum = parseFloat(arr[i][el]) / commonMultiplier;
			arr[i].push(clickNum);
		}
	}
	return arr;
}


/*
Set up accordion and assign click handlers.
*/
function init() {
	panel = document.querySelector(".argument .panel");
	let acc = document.getElementsByClassName("accordion");
	let i;
	let j;
	let limit;
	let subLimit;
	limit = acc.length;
	for (i = 0; i < limit; i++) {
		acc[i].addEventListener("click", function() {
			panel.classList.toggle("expanded");
			panel = this.querySelector(".panel");
			panel.classList.toggle("expanded");
		});
	}
	//Grow main phrasing if character count is low
	let phrasing = document.querySelector(".argument .panel p");
	if (phrasing.innerText.length < 20) {
		phrasing.style.fontSize = "2rem";
	} else if (phrasing.innerText.length < 75) {
		phrasing.style.fontSize = "1.5rem";
	}
	// Assign click handlers for .container elements
	let containers = document.querySelectorAll(".container .panel");
	limit = containers.length;
	for (i = 0; i < limit; i++) {
		containers[i].addEventListener("click", function(evt) {
			// TODO: placeholder for now
			console.log(`${evt.target.parentElement.nodeName} with classes: ${evt.target.parentElement.className}`);
		});
	}
	// Assign click handlers for weighIn buttons
	let weighIns = document.querySelectorAll(".weighIn");
	let resets = document.querySelectorAll(".reset");
	let endorses = document.querySelectorAll(".endorse");
	let histories = document.querySelectorAll(".history");
	let typeClass = "";
	let resetEl = null;
    let endorseEl = null;
    let historyEl = null;
	limit = weighIns.length;
	for (i = 0; i < limit; i++) {
		if (weighIns[i].classList.contains("because")) {
			typeClass = "because";
		}
		else if (weighIns[i].classList.contains("rebuttal")) {
			typeClass = "rebuttal";
		}
		else {
			typeClass = "therefore";
		}	
		subLimit = resets.length;
		for (j = 0; j < subLimit; j++) {
			if (resets[j].classList.contains(typeClass)) {
				resetEl = resets[j];
			}
		}
		subLimit = endorses.length;
		for (j = 0; j < subLimit; j++) {
			if (endorses[j].classList.contains(typeClass)) {
				endorseEl = endorses[j];
			}
		}
		subLimit = histories.length;
		for (j = 0; j < subLimit; j++) {
			if (histories[j].classList.contains(typeClass)) {
				historyEl = histories[j];
			}
		}
		weighIns[i].addEventListener("click", function(evt) {
            this.classList.toggle("hidden");
            resetEl.classList.toggle("hidden");
            endorseEl.classList.toggle("hidden");
            historyEl.classList.toggle("hidden");
            //TODO make it toggle hide buttons of other sections
            goNeutral(typeClass);
            loadUserWeights(typeClass); /*TODO add data for this to reference*/
		});	
	}
	//Assign goNeutral function to the reset button
	limit = resets.length;
	for (i = 0; i < limit; i++) {
		if (weighIns[i].classList.contains("because")) {
			typeClass = "because";
		}
		else if (weighIns[i].classList.contains("rebuttal")) {
			typeClass = "rebuttal";
		}
		else {
			typeClass = "therefore";
		}
		resets[i].addEventListener("click", function(evt) {
            goNeutral(typeClass);
		});		
	}
	//TODO Still would like a history button. resets back historical weights by user, just uses loadUserWeights function. No button to give this fuctionality to yet. 

}

/*
Set all selected type class to neutral. Set inline percentage to zero. 
*/
function goNeutral(type) {
	let circles = document.querySelectorAll(`.container.${type} .wrapper`);
	let limit = circles.length;
	let i;
	/*Make circles grey and no arc*/
	for (i = 0; i < limit; i++) {
		circles[i].classList.replace(type, "neutral");
	}
	/*Make inline percentage 0%*/
	let text = document.querySelectorAll(`.container.${type} p .inLinePct`);
	limit = text.length;
	for (i = 0; i < limit; i++) {
		text[i].innerHTML = "0.00% - ";
	}
	/*empty array tracking clicks and reset counter of total clicks*/
	genericClickArr.length = 0;
	genericTotalClicks = 0;
}

/*
Retrieve weights from .wrapper, via attribute data-user-weight.
Replace pctX_Y value with those weights and store the original in data-aggregate-weight.
*/
function loadUserWeights(type) {
	//if (mode != 'edit') {
		// load values for editing (initial setting is editing from 0)
		let args = document.querySelectorAll(`.container.${type} .wrapper`);
		let text = document.querySelectorAll(`.container.${type} p .inLinePct`);
		let limit = args.length;
		let i;
		for (i = 0; i < limit; i++) {
			let weight = parseInt(args[i].getAttribute('data-user-weight')).toFixed(1);
			let newpct;
			// get pct being used, store it
			let pct = getPct(args[i]);
			//UPDATE: already stored as data attribute   args[i].setAttribute('data-aggregate-weight', pct);
			if (weight !== 0) {
				let [whole, decimal] = weight.split('.');
				newpct = `pct${whole}_${decimal}`;
				args[i].classList.remove("neutral", "half1", "half2", pct);
				if (weight <= 50) {
					args[i].classList.add("half1");
				}
				else {
					args[i].classList.add("half2");
				}
				args[i].classList.add(newpct);
				args[i].classList.add(type);
				//FIX ME This is unreliable assuming the same place in the array as args
				text[i].innerHTML = args[i].getAttribute('data-user-weight') + "% - ";
				//TODO You still need to load up the click array appropriately
				//args[i].classList.replace("neutral", type);
			}
			/*let newpct;
			if (weight.length == 0) {
				// no user weight to show
				newpct = 'pct0_0';
			} else {
				// create value for newpct
				let [whole, decimal] = weight.split('.');
				newpct = `pct${whole}_${decimal}`;
			}
			args[i].classList.remove(type, "half1", "half2", pct);
			args[i].classList.add(newpct);*/
		}
		//get click values to load up generic click array
		let arr;
		switch(type) {
			case 'because':
				arr = pctToClicks(because,3);
				break;
			case 'therefore':
				arr = pctToClicks(therefore,3);
				break;
			case 'rebuttal':
				arr = pctToClicks(rebuttal,3);
				break;
		}
		console.log(arr);
		limit = arr.length;
		for (i = 0; i < limit; i++) {
			if (arr[i][3]) {
				genericClickArr.push([(arr[i][1]),(arr[i][4])]);
				genericTotalClicks = genericTotalClicks + arr[i][4];
			}
		}
		console.log(genericClickArr);
		console.log(genericTotalClicks);
	//}
}


/*
Docs TBD
*/
function bump(element, type, argID) {
	let found = false;
	let iterator = 0;
	let foundIndex;
	let genericTotalClicks;
	let genericClickArr = [];
	/*Does this switch by case section have a purpose anymore?*/
	switch(type) {
		case 'Because':
			genericTotalClicks = becauseTotalClicks;
			genericClickArr = becauseClickArr;		 /* arrays copy by reference... */
			break;
		case 'Therefore':
			genericTotalClicks = thereforeTotalClicks;
			genericClickArr = thereforeClickArr;
			break;
		case 'Rebuttal':
			genericTotalClicks = rebuttalTotalClicks;
			genericClickArr = rebuttalClickArr;
			break;
	}
	genericTotalClicks++;
	while (!found && iterator < genericClickArr.length) {
		if (genericClickArr[iterator][0] == argID) {
			found = true;
			genericClickArr[iterator][1]++;
			foundIndex = iterator;
		}
		iterator++;
	}
	if (found == false) {
		foundIndex = genericClickArr.length;
		genericClickArr.push([argID, 1]);
		let btn = document.getElementById("displayBtn"+type+argID);
		btn.className = "";
	}
	for (let i = 0, limit = genericClickArr.length; i < limit; i++) {
		rateAsString = ((genericClickArr[i][1]/genericTotalClicks)*100).toFixed(1);
		let [whole, decimal] = rateAsString.split('.');
		let newpct = `pct${whole}_${decimal}`;
		element.classList.add(newpct);
		let text = element.querySelector("p .inLinePct");
		text.innerHTML = `${rateAsString}%`;
	}
	/*May only need the update function*/
	switch(type) {
		case 'Because':
			becauseTotalClicks = genericTotalClicks;
			becauseClickArr = genericClickArr.slice();		 /* arrays copy by reference, but you don't want genericClickArr to go out of scope. */
			updateBecauseWeighInValue();
			break;
		case 'Therefore':
			thereforeTotalClicks = genericTotalClicks;
			thereforeClickArr = genericClickArr.slice();
			updateThereforeWeighInValue();
			break;
		case 'Rebuttal':
			rebuttalTotalClicks = genericTotaliClicks;
			rebuttalClickArr = genericClickArr.slice();
			updateRebuttalWeighInValue();
			break;
	}
}

/*
Initialize after DOM content is loaded.
*/
document.addEventListener('DOMContentLoaded', function() {
	init();
});
