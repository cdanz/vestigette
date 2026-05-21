"use strict";

let mode = null;
/*TEMPORARILY DISABLED
Test for new expanded Add More experience - weigh in buttons should be active upon page load 
if(window.location.pathname == '/add_more.php') {
		console.log('add more if condition fired');
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
			 hide this, unhide rest and endorse 
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
    }
*/

const editMode = ['because', 'therefore'];
let activeEditMode;
let panel = null;
let pctRE = /pct\d+\_\d/;
let genericTotalClicks = 0;
let genericClickArr = [];
let phrasingTotalClicks = 0;
let phrasingClickArr = [];
let explicTotalClicks = 0;
let explicClickArr = [];
let DEBUG = true;
const matchMediaValue = '(max-width: 1200px)';

/*
Better simple nav
*/
function openNav() {
	document.querySelector("#mastHead div").classList.add("shownav");
}
function closeNav() {
	document.querySelector("#mastHead div").classList.remove("shownav");
}


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
	if (id === 'phrasing') {
		phrasingClickArr.length = 0;
		phrasingTotalClicks = 0;
		updatePhrasingWeighInValue();
	} else if (id === 'explication') {
		explicClickArr.length = 0;
		explicTotalClicks = 0;
		updateExplicationWeighInValue();
	} else {
		genericClickArr.length = 0;
		genericTotalClicks = 0;
		updateWeighInValue(id);
	}
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
	let i, limit;
	resize('init');
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
					fireClick(type);
					if (mode == 'EDIT' && inCircle(evt, evt.target)) {
						if (type === 'phrasing') {
							if (DEBUG) console.log(`in circle phrasing ${evt.target.parentNode.parentNode.dataset.phrasingId}`);
							bumpPhrasing(evt.target.parentNode.parentNode.dataset.phrasingId);
						} else if (type === 'explication') {
							if (DEBUG) console.log(`in circle explication ${evt.target.parentNode.parentNode.dataset.explicationId}`);
							bumpExplication(evt.target.parentNode.parentNode.dataset.explicationId);
						} else {
							if (DEBUG) console.log(`in circle ${evt.target.parentNode.nextElementSibling.children[0].innerHTML}`);
							bump(type, evt.target.parentNode.parentNode.dataset.argId);
						}
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
	if(openPutForth){
		openPutForth.addEventListener("click", function(evt) {
			overlayP.classList.toggle("hidden");
			putforth.classList.toggle("hidden");
		});
	}


	// edit entry when you are the only endorser
	let rewriteEl = document.querySelectorAll(".rewrite");
	let rewriteBtn = document.getElementById("rewriteBtn");
	if(rewriteBtn){
		rewriteBtn.addEventListener("click", function(evt) {
			limit = rewriteEl.length;
			for (i = 0; i < limit; i++) {
				rewriteEl[i].classList.toggle("hidden");
				console.log(rewriteEl[i]);
			}
		});
    }

		// close put forths button -- remove overlay
	let closeP = document.getElementById("closeP");
	if (closeP) {
		closeP.addEventListener("click", function(evt) {
			overlayP.classList.toggle("hidden");
			putforth.classList.toggle("hidden");
		});
	}




	// explication button -- open overlay
	let openExplication = document.querySelector(".altExplicationBtn");
	if(openExplication) {
		openExplication.addEventListener("click", function(evt) {
			overlayE.classList.toggle("hidden");
			links.classList.toggle("hidden");
		});
	}

	
	// close explication button -- remove overlay
	let closeE = document.getElementById("closeE");
	if (closeE) {
		closeE.addEventListener("click", function(evt) {
			overlayE.classList.toggle("hidden");
			links.classList.toggle("hidden");
		});
	}


	// Find sub-section toggles
	document.querySelectorAll('.find-toggle').forEach(function(toggle) {
		toggle.addEventListener('click', function() {
			let content = this.nextElementSibling;
			if (content) {
				content.classList.toggle('collapsed');
				this.classList.toggle('collapsed');
			}
		});
	});

	//Filter button
	let toggle1 = document.getElementById("filter1");
	let toggleLabelA = document.getElementById("filter1A");
	let toggleLabelB = document.getElementById("filter1B");
	if(toggleLabelB) {
		toggleLabelB.style.color = "var(--cddbGrey)";
	}
	if (toggle1) {
		toggle1.addEventListener("click", function(evt) {
			if(document.getElementById("check1").checked) {
				toggleLabelA.style.color = "var(--cddbGrey)";
				toggleLabelB.style.color = "var(--cddbBlue)";
			}
			else {
				toggleLabelA.style.color = "var(--cddbBlack)";
				toggleLabelB.style.color = "var(--cddbGrey)";
			}
		});
	}


	//Checkbox on Checkpoint page to reciprocate
	let checkbox = document.querySelector("input[type=checkbox]"); 
	let stickWithThis = document.querySelector(".stick");
	let useInstead = document.querySelectorAll(".instead"); 
	limit = useInstead.length;
	if(checkbox) {
		checkbox.addEventListener("change", function(evt) {
			if(evt.target.checked) {
				stickWithThis.value = "addAssertionAndReciprocate";
				for (i = 0; i < limit; i++) {
					useInstead[i].value = "useInsteadAndReciprocate";
				}
			}
			else {
				stickWithThis.value = "addAssertion";
				for (i = 0; i < limit; i++) {
					useInstead[i].value = "useInstead";											
				}
			}
		});
	}


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
	if (id === 'phrasing') {
		updatePhrasingWeighInValue();
		return;
	}
	if (id === 'explication') {
		updateExplicationWeighInValue();
		return;
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
		default:
			arr = [];
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
Use with filter. Display the current user's selections. 
*/
function displayUserEndorsements(id) {
	if (DEBUG) console.log(`displayUserEndorsements: id: ${id}`);
	//if (mode != 'edit') {
		// load values for editing (initial setting is editing from 0)
	let args = document.querySelectorAll(`#${id} .lineItem`);
	let limit = args.length;
	let i;
	for (i = 0; i < limit; i++) {
		if (DEBUG) console.log(`displayUserEndorsements: for loop (${i.toString()} < ${limit.toString()})`);
		let weight = parseFloat(args[i].dataset.userWeight);
		if (DEBUG) console.log(`displayUserEndorsements: weight: ${weight} as ${typeof weight}`);
		// get pct being used, store it
		let pct = getExistingPct(args[i]);
		//UPDATE: already stored as data attribute   args[i].setAttribute('data-aggregate-weight', pct);
		if (weight !== 0) {
			let newpct = getPctClass(weight);
			if (DEBUG) console.log(`displayUserEndorsements: newpct: ${newpct}`);
			args[i].classList.remove("half1", "half2", pct);
			if (weight <= 50) {
				args[i].classList.add("half1");
			}
			else {
				args[i].classList.add("half2");
			}
			if (DEBUG) console.log(`displayUserEndorsements: adding ${newpct}...`)
			args[i].classList.add(newpct);
			setInlinePct(args[i], weight);
			//args[i].classList.replace("neutral", type);
		}
	}
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

function bumpPhrasing(phrasingID) {
	phrasingTotalClicks++;
	let ndx = phrasingClickArr.findIndex((tuple) => tuple[0] == phrasingID);
	if (ndx >= 0) {
		phrasingClickArr[ndx][1] += 1;
	} else {
		phrasingClickArr.push([phrasingID, 1]);
	}

	let args = document.querySelectorAll('#phrasing .lineItem');
	let limit = args.length;
	for (let i = 0; i < limit; i++) {
		let value = 0;
		for (let j = 0; j < phrasingClickArr.length; j++) {
			if (phrasingClickArr[j][0] == args[i].dataset.phrasingId) {
				value = phrasingClickArr[j][1];
				break;
			}
		}
		if (value > 0) {
			let rate = (value / phrasingTotalClicks) * 100;
			let pct = getExistingPct(args[i]);
			let newpct = getPctClass(rate);
			args[i].classList.remove("half1", "half2", pct);
			if (rate <= 50) {
				args[i].classList.add("half1");
			} else {
				args[i].classList.add("half2");
			}
			if (DEBUG) console.log(`bumpPhrasing: adding ${newpct}...`);
			args[i].classList.add(newpct);
			setInlinePct(args[i], rate);
		}
	}
	console.log(phrasingClickArr);
	updatePhrasingWeighInValue();
}

function updatePhrasingWeighInValue() {
	var arrayAsString = "";
	for (var i = 0; i < phrasingClickArr.length; i++) {
		arrayAsString = arrayAsString + phrasingClickArr[i][0] + ",";
		arrayAsString = arrayAsString + ((phrasingClickArr[i][1] / phrasingTotalClicks) * 100).toFixed(5) + ",";
	}
	document.getElementById("phrasingWeighInWith").value = arrayAsString;
}

function bumpExplication(explicationID) {
	explicTotalClicks++;
	let ndx = explicClickArr.findIndex((tuple) => tuple[0] == explicationID);
	if (ndx >= 0) {
		explicClickArr[ndx][1] += 1;
	} else {
		explicClickArr.push([explicationID, 1]);
	}

	let args = document.querySelectorAll('#explication .lineItem');
	let limit = args.length;
	for (let i = 0; i < limit; i++) {
		let value = 0;
		for (let j = 0; j < explicClickArr.length; j++) {
			if (explicClickArr[j][0] == args[i].dataset.explicationId) {
				value = explicClickArr[j][1];
				break;
			}
		}
		if (value > 0) {
			let rate = (value / explicTotalClicks) * 100;
			let pct = getExistingPct(args[i]);
			let newpct = getPctClass(rate);
			args[i].classList.remove("half1", "half2", pct);
			if (rate <= 50) {
				args[i].classList.add("half1");
			} else {
				args[i].classList.add("half2");
			}
			if (DEBUG) console.log(`bumpExplication: adding ${newpct}...`);
			args[i].classList.add(newpct);
			setInlinePct(args[i], rate);
		}
	}
	console.log(explicClickArr);
	updateExplicationWeighInValue();
}

function updateExplicationWeighInValue() {
	var arrayAsString = "";
	for (var i = 0; i < explicClickArr.length; i++) {
		arrayAsString = arrayAsString + explicClickArr[i][0] + ",";
		arrayAsString = arrayAsString + ((explicClickArr[i][1] / explicTotalClicks) * 100).toFixed(5) + ",";
	}
	document.getElementById("explicWeighInWith").value = arrayAsString;
}

/*
This is the named function used for accordion expansion
*/
function accordionExpand(evt) {
	// Ignore clicks that originated inside the panel or on interactive elements
	if (evt.target.closest('.panel, button, a, input, select, textarea, form')) return;

	let targetPanel = this.querySelector('.panel');
	let isOpen = targetPanel.classList.contains('expanded');

	// Close all accordion panels
	document.querySelectorAll('.accordion .panel').forEach(function(p) {
		p.classList.remove('expanded');
	});

	// If this one wasn't already open, open it now
	if (!isOpen) {
		targetPanel.classList.add('expanded');
	}
}


/*
We want to resize things and not rely on the initial load size
*/
function resize(why) {
	let acc = document.getElementsByClassName("accordion");
	let i, limit;
	limit = acc.length;
	// Add accordion listeners to each section container — always, no matchMedia gate.
	// Clicks inside .panel or interactive elements are filtered in accordionExpand.
	for (i = 0; i < limit; i++) {
		if (!acc[i].classList.contains('listening')) {
			acc[i].addEventListener("click", accordionExpand);
			acc[i].classList.add('listening');
		}
	}
	//Grow main phrasing if character count is low
	let phrasing = document.querySelector("#argument .panel p");
	if (phrasing && phrasing.innerText.length < 20) { //if phrasing is null it should evaluate to false and skip this
		phrasing.style.fontSize = "2rem";
	} else if (phrasing && phrasing.innerText.length < 75) { //same as previous. avoid nulls at checkpoint
		phrasing.style.fontSize = "1.5rem";
	}
}


/*
Initialize after DOM content is loaded.
*/
document.addEventListener('DOMContentLoaded', function() {
	init();
});

window.addEventListener("orientationchange", function() {
	resize('orientationchange');
});