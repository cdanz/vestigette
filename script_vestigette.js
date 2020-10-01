"use strict";

let mode = null;
const editMode = ['because', 'therefore'];
let activeEditMode;
let panel = null;
let pctRE = /pct\d+\_\d/;
let genericTotalClicks = 0;
let genericClickArr = [];
let DEBUG = true;


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
	inLinePct.innerHTML = `${value.toFixed(2)}% - `;
}


/*
Actually do actions upon click.
*/
function fireClick(type) {
	if (DEBUG) console.log(`fireClick: click occurred in ${type}; mode is ${mode}`);
}


/*
For a given element el, set all of its wrapper children to neutral.
*/
function neutralizeSection(id) {
	let x = document.querySelectorAll(`#${id} .lineItem`);
	let i;
	let limit = x.length;
	for (i = 0; i < limit; i++) {
		if (x[i].classList.contains("half2")) {
			x[i].classList.replace("half2", "half1");
		}
		x[i].classList.replace(getExistingPct(x[i]), 'pct0_0');
		setInlinePct(x[i], 0);
	}
	/*empty array tracking clicks and reset counter of total clicks*/
	genericClickArr.length = 0;
	genericTotalClicks = 0;
	updateWeighInValue(id);
}

/*
Update hidden value submitted with endorse button.
*/
function updateWeighInValue(type) {
	var arrayAsString = "";
	for (var i = 0; i < genericClickArr.length; i++) {
		arrayAsString = arrayAsString + genericClickArr[i][0] + ","; 
		arrayAsString = arrayAsString + ((genericClickArr[i][1]/genericTotalClicks)*100).toFixed(5) + ",";
	}
	document.getElementById(`${type}WeighInWith`).value = arrayAsString;
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
	function inCircle(evt, el) {
		let rect = el.getBoundingClientRect();
		let radius = ((rect.right - rect.x) / 2);
		let [centerX, centerY] = [rect.x + radius, rect.y + radius];
		let [x1, y1] = [evt.clientX, evt.clientY];
		let d = Math.sqrt(Math.pow(x1-centerX,2) + Math.pow(y1-centerY,2));
		if (DEBUG) console.log(`inCircle: ${el.nodeName}.${el.className}: 0=[${centerX},${centerY}], 1=[${x1},${y1}], radius: ${radius}, d: ${d}`);
		return (d < radius);
	}

	let containers = document.querySelectorAll(".container .panel");
	limit = containers.length;
	for (i = 0; i < limit; i++) {
		containers[i].addEventListener("click", function(evt) {
			if (DEBUG) console.log(`click: ${evt.target.nodeName} with classes ${evt.target.className} (via ${evt.currentTarget.nodeName}, ${evt.currentTarget.className})`);
			let type = this.dataset.containerId;
			if (type != undefined) {
				if (evt.target.classList.contains('pointBtn')) { // don't allow the click on just any click on that panel
					// TODO: technically, this should be a circle and not a square... something to tweak later.
					fireClick(type);
					if (mode == 'EDIT' && inCircle(evt, evt.target)) {
						if (DEBUG) console.log(`in circle ${evt.target.parentNode.nextElementSibling.children[0].innerHTML}`);
						bump(type, evt.target.parentNode.parentNode.dataset.argId);
					}
				}
			}
		});
	}
	// Assign click handlers for weighIn buttons
	let weighIns = document.querySelectorAll(".weighIn");
	let typeClass = "";
	let resetEl = null;
	let endorseEl = null;
	let assertEl = null;
	limit = weighIns.length;
	for (i = 0; i < limit; i++) {
		weighIns[i].addEventListener("click", function(evt) {
			let which;
			// 1) set mode to edit, 2) toggle hidden of other buttons, 3) set all "type" circles to neutral
			if (mode != 'EDIT') { // cold edit, use what was clicked
				mode = 'EDIT';
				activeEditMode = this.dataset.containerId;
				which = this;
				document.getElementById(`${activeEditMode}`).classList.toggle('edit');
			} else { // warm edit, use the other click option -- this should only happen between the two editModes
				if (this.dataset.containerId == activeEditMode) {
					// do nothing
					return;
				} else { // use the other option, which should only exist for because/therefore
					let oldEditMode = activeEditMode;
					activeEditMode = editMode[(editMode.indexOf(oldEditMode) + 1) % 2]; // 0=> 1, 1=> 0
					which = document.querySelector(`#${activeEditMode} .weighIn`);
					// untoggle the last one
					let previous = document.querySelector(`#${oldEditMode} .weighIn`);
					previous.classList.toggle("hidden");
					resetEl = document.querySelector(`#${oldEditMode} .reset`);
					resetEl.classList.toggle("hidden");
					endorseEl = document.querySelector(`#${oldEditMode} .endorse`);
					endorseEl.classList.toggle("hidden");
					assertEl = document.querySelector(`#${oldEditMode} .assert`);
					assertEl.classList.toggle("hidden");
					// clear genericClickArr
					genericClickArr.length = 0;
					genericTotalClicks = 0;
					// now you can toggle the new one, continue
				}
			}
			/* hide this, unhide rest and endorse */
			which.classList.toggle("hidden");
			resetEl = document.querySelector(`#${activeEditMode} .reset`);
			resetEl.classList.toggle("hidden");
			endorseEl = document.querySelector(`#${activeEditMode} .endorse`);
			endorseEl.classList.toggle("hidden");
			assertEl = document.querySelector(`#${activeEditMode} .assert`);
			assertEl.classList.toggle("hidden");
			neutralizeSection(activeEditMode);
			// if there is data for this, set the wrappers to reflect the user's values
			loadUserWeights(activeEditMode);
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
	// buttons for editing and viewing phrasing or explication with overlays
	let overlayP = document.getElementById("overlayP");
	let overlayE = document.getElementById("overlayE");
	let putforth = document.getElementById("phrasing");
	let links = document.getElementById("explication");

	// putforth button -- open overlay
	let openPutForth = document.querySelector(".altPhraseBtn");
	openPutForth.addEventListener("click", function(evt) {
		overlayP.classList.toggle("hidden");
		putforth.classList.toggle("hidden");
	});
	// explication button -- open overlay
	let openExplication = document.querySelector(".altExplicationBtn");
	openExplication.addEventListener("click", function(evt) {
		overlayE.classList.toggle("hidden");
		links.classList.toggle("hidden");
	});
	
	// close put forths button -- remove overlay
	let closeP = document.getElementById("closeP");
	closeP.addEventListener("click", function(evt) {
		overlayP.classList.toggle("hidden");
		putforth.classList.toggle("hidden");
	});
	// close explication button -- remove overlay
	let closeE = document.getElementById("closeE");
	closeE.addEventListener("click", function(evt) {
		overlayE.classList.toggle("hidden");
		links.classList.toggle("hidden");
	});
	// endorse button -- submit form 
	// endorse click handler needs to EXIT edit mode -- but since it's submitting, the page will reload anyway
	// let endorses = document.querySelectorAll(".endorse");
	// TODO Still would like a history button. resets back historical weights by user, just uses 
	// loadUserWeights function. No button to give this fuctionality to yet. 
}


/*
Retrieve weights from .wrapper, via attribute data-user-weight.
Replace pctX_Y value with those weights and store the original in data-aggregate-weight.
*/
function loadUserWeights(id) {
	if (DEBUG) console.log(`loadUserWeights: id: ${id}`);
	//if (mode != 'edit') {
		// load values for editing (initial setting is editing from 0)
	let args = document.querySelectorAll(`#${id} .lineItem`);
	let limit = args.length;
	let i;
	for (i = 0; i < limit; i++) {
		if (DEBUG) console.log(`loadUserWeights: for loop (${i.toString()} < ${limit.toString()})`);
		let weight = parseFloat(args[i].dataset.userWeight);
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
	updateWeighInValue(id);
}


/*
Docs TBD
*/
function bump(type, argID) {
	let found = false;
	let iterator = 0;
	let rateAsString;
	let element;

	function getValueFrom2DArray(array, key) {
		let returnval = 0;
		for (let i=0; i < array.length; i++) {
			if (array[i][0] == key) {
				return array[i][1]; // this can't be zero
			}
		}
		return returnval; // this is zero
	}

// increment genericTotalClicks because a click has happened
	genericTotalClicks++;
//	if (genericClickArr.some(row => row.includes(argID))) { // this one shows if something exists
	let ndx = genericClickArr.findIndex((tuple) => tuple[0] == argID); // this returns the index of something that exists or -1 if it doesn't
	if (ndx >= 0) { // found
		// go through the type's lineItems and do that stuff below
		genericClickArr[ndx][1] += 1;
	} else { // argID not in genericClickArr, so add its initial state
		genericClickArr.push([argID, 1]);
	}
	// now genericClickArr reflects reality, so update display
	let args = document.querySelectorAll(`#${type} .lineItem`);
	let i;
	let limit = args.length;
	for (i = 0; i < limit; i++) {
		// for every argID in our panel, if it's in genericClickArr, update its display
		let value = getValueFrom2DArray(genericClickArr, args[i].dataset.argId);
		if (value > 0) {
			// update
			let rate = (value/genericTotalClicks) * 100;
			let pct = getExistingPct(args[i]);
			let newpct = getPctClass(rate);
			args[i].classList.remove("half1", "half2", pct);
			if (rate <= 50) {
				args[i].classList.add("half1");
			} else {
				args[i].classList.add("half2");
			}
			if (DEBUG) console.log(`bump: adding ${newpct}...`)
			args[i].classList.add(newpct);
			setInlinePct(args[i], rate);
		}
	}
/*
	while (!found && iterator < genericClickArr.length) {
		if (genericClickArr[iterator][0] == argID) {
			found = true;
			genericClickArr[iterator][1]++;
		}
		iterator++;
	}
	if (found == false) {
		genericClickArr.push([argID, 1]);
	}
	for (let i = 0, limit = genericClickArr.length; i < limit; i++) {
		let args = document.querySelectorAll(`#${type} .lineItem`);
		let sublimit = args.length;
		let j;
		for (j = 0; j < sublimit; j++) {
			if (args[j].dataset.argId == genericClickArr[i][0]) {
				rateAsString = ((genericClickArr[i][1]/genericTotalClicks)*100).toFixed(2);
				let pct = getExistingPct(args[j]);
				let newpct = getPctClass((genericClickArr[i][1]/genericTotalClicks)*100);
				args[j].classList.remove("half1", "half2", pct);
				if (((genericClickArr[i][1]/genericTotalClicks)*100) <= 50) {
					args[j].classList.add("half1");
				}
				else {
					args[j].classList.add("half2");
				}	
				if (DEBUG) console.log(`loadUserWeights: adding ${newpct}...`)
				args[j].classList.add(newpct);
				setInlinePct(args[j], rateAsString);
			}
		}
	}
*/
	console.log(genericClickArr);
	updateWeighInValue(type);
}

/*
Initialize after DOM content is loaded.
*/
document.addEventListener('DOMContentLoaded', function() {
	init();
});
