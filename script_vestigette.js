"use strict";

let mode = null;
let panel = null;
let editMode = null;
let pctRE = /pct\d+\_\d/;
let genericTotalClicks = 0;
let genericClickArr = [];
let DEBUG = false;


/*
Capitalize a given str.
*/
function capitalize(str) {
	return str.charAt(0).toUpperCase() + str.slice(1);
}


/*
Return pctX_Y from element's classList.
*/
function getExistingPct(element) {
	let pctmatch = element.className.match(pctRE);
	return pctmatch[0];
}


/*
Return multidimensional array with number of clicks pushed to end of row that 
already includes percents, el gives position of el to perform on
*/
function pctToClicks(arr, el) { 
	let clickArr = [];
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
			clickArr.push([arr[i][0],clickNum]);
		}
	}
	return clickArr;
}


/*
Return the class representing the passed-in float; 0 otherwise.
*/
function getPctClass(float) {
	let value = float;
	if (typeof value !== 'number') {
		value = parseInt(value, 10);
		if (isNaN(value)) value = '0.0';
	}
	let [whole, decimal] = value.toFixed(1).split('.');
	return `pct${whole}_${decimal}`;
}


/*
Return type from given string.
*/
function getType(string) {
	// type: because, rebuttal, therefore
	if (string.indexOf('because') > 0) return 'because';
	if (string.indexOf('rebuttal') > 0) return 'rebuttal';
	if (string.indexOf('therefore') > 0) return 'therefore';
	return undefined;
}


/*
For a given element, set its child with class inLinePct to value
*/
function setInlinePct(el, value) {
	let inLinePct = el.querySelector(".inLinePct");
	inLinePct.innerHTML = `${value.toString()}% - `;
}


/*
Actually do actions upon click.
*/
function fireClick(type) {
	if (DEBUG) console.log(`fireClick: click occurred on ${type} wrapper; mode is ${mode}`);
}


/*
For a given element el, set all of its wrapper children to neutral.
*/
function neutralizeSection(id) {
	let x = document.querySelectorAll(`#${id} .lineItem`);
	let i;
	let limit = x.length;
	for (i = 0; i < limit; i++) {
		x[i].classList.replace(getExistingPct(x[i]), 'pct0_0');
		setInlinePct(x[i], 0);
	}
	/*empty array tracking clicks and reset counter of total clicks*/
	genericClickArr.length = 0;
	genericTotalClicks = 0;
}


/*
Set up accordion and assign click handlers.
*/
function init() {
	panel = document.querySelector("#argument .panel");
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
	let phrasing = document.querySelector("#argument .panel p");
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
			let type = this.dataset.containerId;
			if (type != undefined) {
				if (evt.target.classList.contains('wrapper')) { // don't allow the click on just any click on that panel
					// TODO: technically, this should be a circle and not a square... something to tweak later.
					fireClick(type);
				}
			}
		});
	}
	// Assign click handlers for weighIn buttons
	let weighIns = document.querySelectorAll(".weighIn");
	let typeClass = "";
	let resetEl = null;
	let endorseEl = null;
	limit = weighIns.length;
	for (i = 0; i < limit; i++) {
		weighIns[i].addEventListener("click", function(evt) {
			// 1) set mode to edit, 2) toggle hidden of other buttons, 3) set all "type" circles to neutral
/*
			if (mode != 'EDIT') {
				mode = 'EDIT';
			}
*/
			/* hide this, unhide rest and endorse */
			this.classList.toggle("hidden");
			resetEl = document.querySelector(`#${this.dataset.containerId} .reset`);
			resetEl.classList.toggle("hidden");
			endorseEl = document.querySelector(`#${this.dataset.containerId} .endorse`);
			endorseEl.classList.toggle("hidden");
			neutralizeSection(this.dataset.containerId);
			// if there is data for this, set the wrappers to reflect the user's values
			loadUserWeights(this.dataset.containerId);
		});
	}
	// reset button -- just go neutral
	let resets = document.querySelectorAll(".reset");
	limit = resets.length;
	for (i = 0; i < limit; i++) {
		resets[i].addEventListener("click", function(evt) {
			neutralizeSection(this.dataset.containerId);

		});
	}
	// endorse button -- submit form
	let endorses = document.querySelectorAll(".endorse");
	// TODO Still would like a history button. resets back historical weights by user, just uses 
	// loadUserWeights function. No button to give this fuctionality to yet. 
}


/*
Retrieve weights from .wrapper, via attribute data-user-weight.
Replace pctX_Y value with those weights and store the original in data-aggregate-weight.
*/
function loadUserWeights(id) {
	if (DEBUG) console.log(`loadUserWeights: ${id}`);
	//if (mode != 'edit') {
		// load values for editing (initial setting is editing from 0)
	let args = document.querySelectorAll(`#${id} .lineItem`);
	let limit = args.length;
	let i;
	for (i = 0; i < limit; i++) {
		if (DEBUG) console.log(`loadUserWeights: for loop (${i.toString()} < ${limit.toString()})`);
		let weight = parseInt(args[i].dataset.userWeight);
		if (DEBUG) console.log(`loadUserWeights: weight: ${weight} as ${typeof weight}`);
		// get pct being used, store it
		let pct = getExistingPct(args[i]);
		//UPDATE: already stored as data attribute   args[i].setAttribute('data-aggregate-weight', pct);
		if (weight !== 0) {
			let newpct = getPctClass(weight);
			if (DEBUG) console.log(`loadUserWeights: newpct: ${newpct}`);
			args[i].classList.remove("half1", "half2", pct);
			if (weight <= 50) {
				args[i].classList.add("half1");
			}
			else {
				args[i].classList.add("half2");
			}
			if (DEBUG) console.log(`loadUserWeights: adding ${newpct}...`)
			args[i].classList.add(newpct);
			setInlinePct(args[i], weight);
			//TODO You still need to load up the click array appropriately
			//args[i].classList.replace("neutral", type);
		}
	}
	//get click values to load up generic click array
	let arr;
	switch(id) {
		case 'because':
			arr = pctToClicks(because, 3);
			break;
		case 'therefore':
			arr = pctToClicks(therefore, 3);
			break;
		case 'rebuttal':
			arr = pctToClicks(rebuttal, 3);
			break;
	}
	console.log(`loadUserWeights: arr: ${arr}`);
	limit = arr.length;
	for (i = 0; i < limit; i++) {
		genericClickArr.push([(arr[i][0]),(arr[i][1])]);
		genericTotalClicks = genericTotalClicks + arr[i][1];
	}
	console.log(`loadUserWeights: genericClickArr: ${genericClickArr}`);
	console.log(`loadUserWeights: genericTotalClicks: ${genericTotalClicks}`);
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
		let newpct = getPctClass(rateAsString);
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
