"use strict";

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

let panel = null;
let pctRE = /pct\d+\_\d/;
// Per-section state replaces the old shared genericClickArr/genericTotalClicks.
// Each section tracks its own clicks independently to prevent cross-contamination.
const sectionState = {
	because:     { mode: 'idle', clickArr: [], totalClicks: 0 },
	therefore:   { mode: 'idle', clickArr: [], totalClicks: 0 },
	rebuttal:    { mode: 'idle', clickArr: [], totalClicks: 0 },
	phrasing:    { mode: 'idle' },
	explication: { mode: 'idle' }
};
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
	return pctmatch ? pctmatch[0] : null;
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
For a given element el, set all of its wrapper children to neutral.
*/
// Paint one line item from a percentage: fill the ring (--pct + the % inside),
// and keep the legacy arc classes / inline % updated so non-ring pages still
// render from the same call.
function paintLine(el, pct) {
	el.style.setProperty('--pct', pct.toFixed(2));
	let val = el.querySelector('.val');
	if (val) val.textContent = Math.round(pct) + '%';
	let m = el.className.match(pctRE);
	if (m) el.classList.remove(m[0]);
	el.classList.remove('half1', 'half2');
	el.classList.add(pct <= 50 ? 'half1' : 'half2', getPctClass(pct));
	let ip = el.querySelector('.inLinePct');
	if (ip) ip.innerHTML = pct.toFixed(2) + '% - ';
}

function neutralizeSection(id) {
	let x = document.querySelectorAll(`#${id} .lineItem`);
	let i;
	let limit = x.length;
	for (i = 0; i < limit; i++) {
		paintLine(x[i], 0);
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
		if (sectionState[id]) {
			sectionState[id].clickArr.length = 0;
			sectionState[id].totalClicks = 0;
		}
		updateWeighInValue(id);
	}
}

/*
Update hidden value submitted with endorse button.
*/
function updateWeighInValue(type) {
	let state = sectionState[type];
	if (!state) return;
	let el = document.getElementById(`${type}WeighInWith`);
	if (!el) return;
	let arrayAsString = "";
	for (let i = 0; i < state.clickArr.length; i++) {
		arrayAsString += state.clickArr[i][0] + ",";
		arrayAsString += ((state.clickArr[i][1] / state.totalClicks) * 100).toFixed(5) + ",";
	}
	el.value = arrayAsString;
}


/*
─── Press-and-hold acceleration for weight circles ──────────────────────────
A tap increments once (the caller fires the first increment itself). If the
press is held past a short threshold, auto-repeat begins and accelerates along
a logistic (S-curve): the count climbs gently at first — slow enough to stay
predictable and let a user stop on a target number — then ramps up to a fast
cap so pushing one argument to a high share (e.g. 99%) takes a couple of
seconds of holding instead of a hundred taps.

Why a logistic ramp driven by requestAnimationFrame (not a shrinking
setInterval):
  • A time-integrated rAF loop accumulates fractional increments per frame, so
    the *speed* is smooth and frame-rate independent — no visible stepping as
    the interval would shorten.
  • The S-curve mirrors the accepted feel of OS key-repeat and stepper
    controls: a deliberate initial delay (tap vs. hold), an easy-to-arrest slow
    zone, a quick acceleration through the middle, and a useful terminal speed.
Tunables below are expressed in human terms (increments/sec, seconds) so the
feel can be adjusted without touching the loop.
*/
const JOY = {
	INITIAL_DELAY: 250, // ms held before the ramp engages (tap vs hold)
	DOWN_FLIP: 24,      // px of downward pull to flip into reduce (gentler than the old 40)
	DOWN_RELEASE: 16,   // px back up to return to add (< DOWN_FLIP → hysteresis)
	UP_RANGE: 120,      // px of upward pull for full add speed
	DOWN_RANGE: 120,    // px of downward pull (past the flip) for full reduce speed
	RATE_MIN: 1,        // increments/sec at the gentle end
	RATE_MAX: 10,       // increments/sec cap
	FLOOR: 0.12         // fraction of range you still get holding at the start point
};
let joy = null; // active hold context, or null

function joyClamp(v, lo, hi) { return v < lo ? lo : v > hi ? hi : v; }
// Instantaneous speed (increments/sec) from joystick position + time-in-direction.
function joyRate(dir, dyUp, tInDir) {
	let pos = dir > 0
		? joyClamp(dyUp / JOY.UP_RANGE, 0, 1)
		: joyClamp((-dyUp - JOY.DOWN_FLIP) / JOY.DOWN_RANGE, 0, 1);
	let L = 1 / (1 + Math.exp(-5 * (tInDir - 0.6)));
	let throttle = joyClamp((JOY.FLOOR + (1 - JOY.FLOOR) * pos) * (0.35 + 0.65 * L), 0, 1);
	return JOY.RATE_MIN + (JOY.RATE_MAX - JOY.RATE_MIN) * throttle;
}
function joyBuzz() { if (navigator.vibrate) { try { navigator.vibrate(20); } catch (e) {} } }

// Begin a hold. cfg: { ring, line, originY, up, down, canReduce, receiving }.
// The caller fires the first `up()` itself, so a quick tap yields one increment.
function startHold(cfg) {
	stopHold();
	joy = { cfg: cfg, dir: 1, acc: 0, originY: cfg.originY, curY: cfg.originY,
	        dirStart: 0, last: 0, delayTimer: null, raf: null };
	cfg.line.classList.add('active');
	cfg.ring.style.setProperty('--glow', '0');
	let g0 = cfg.ring.querySelector('.glyph'); if (g0) g0.textContent = '▲';
	joy.delayTimer = setTimeout(function() {
		// Lift the ring to fixed positioning FIRST (captures its pre-scale spot),
		// so the enlarged circle escapes the scrollable panel's clip and paints in
		// front of the section header instead of behind it. Then enlarge.
		growLift(cfg.ring);
		cfg.ring.classList.add('grow');
		joy.dirStart = performance.now();
		joy.last = performance.now();
		joy.raf = requestAnimationFrame(joyLoop);
	}, JOY.INITIAL_DELAY);
}
// Pin the ring in place with position:fixed so no ancestor overflow can clip the
// enlarged circle; a spacer keeps the row from reflowing while it's lifted.
function growLift(w) {
	if (w._ph) return;
	let r = w.getBoundingClientRect();
	let cs = getComputedStyle(w);
	let ph = document.createElement('span');
	ph.className = 'grow-ph';
	ph.style.cssText = 'display:block;width:' + r.width + 'px;height:' + r.height + 'px;margin:' + cs.margin + ';';
	w.parentNode.insertBefore(ph, w);
	w._ph = ph;
	w.style.position = 'fixed';
	w.style.margin = '0';
	w.style.left = r.left + 'px';
	w.style.top = r.top + 'px';
	w.style.zIndex = '9999';
}
function growDrop(w) {
	if (w._ph) { w._ph.remove(); w._ph = null; }
	w.style.position = '';
	w.style.margin = '';
	w.style.left = '';
	w.style.top = '';
	w.style.zIndex = '';
}
function joyLoop(now) {
	if (!joy) return;
	let cfg = joy.cfg;
	let dt = (now - joy.last) / 1000; joy.last = now;
	let dyUp = joy.originY - joy.curY; // + = pulled up
	if (cfg.canReduce && cfg.canReduce()) {
		if (joy.dir > 0 && dyUp <= -JOY.DOWN_FLIP) { joy.dir = -1; joy.dirStart = now; joy.acc = 0; joyBuzz(); }
		else if (joy.dir < 0 && dyUp >= -JOY.DOWN_RELEASE) { joy.dir = 1; joy.dirStart = now; joy.acc = 0; joyBuzz(); }
	} else if (joy.dir < 0) {
		joy.dir = 1; joy.dirStart = now; joy.acc = 0; // nothing left to reduce → back to add
	}
	let r = joyRate(joy.dir, dyUp, (now - joy.dirStart) / 1000);
	joy.acc += r * dt;
	while (joy.acc >= 1) { (joy.dir > 0 ? cfg.up : cfg.down)(); joy.acc -= 1; }
	let down = joy.dir < 0;
	cfg.line.classList.toggle('reducing', down);
	cfg.ring.style.setProperty('--glow', down ? '0' : joyClamp(r / JOY.RATE_MAX, 0, 1).toFixed(3));
	let g = cfg.ring.querySelector('.glyph'); if (g) g.textContent = down ? '▼' : '▲';
	if (cfg.receiving) cfg.receiving(down);
	joy.raf = requestAnimationFrame(joyLoop);
}
function stopHold() {
	if (!joy) return;
	if (joy.delayTimer) clearTimeout(joy.delayTimer);
	if (joy.raf) cancelAnimationFrame(joy.raf);
	joy.cfg.line.classList.remove('active', 'reducing');
	joy.cfg.ring.classList.remove('grow');
	joy.cfg.ring.style.removeProperty('--glow');
	growDrop(joy.cfg.ring);
	if (joy.cfg.receiving) joy.cfg.receiving(false);
	joy = null;
}

// Track the finger anywhere (pointer capture keeps events flowing), suppress
// native scroll for the whole hold, and end on release/cancel/blur.
document.addEventListener('pointermove', function(e) { if (joy && e.isPrimary) joy.curY = e.clientY; });
document.addEventListener('touchmove', function(e) { if (joy) e.preventDefault(); }, { passive: false });
['pointerup', 'pointercancel'].forEach(function(ev) { document.addEventListener(ev, stopHold); });
window.addEventListener('blur', stopHold);

// Beneficiaries of a reduce = the OTHER items in this section that carry weight.
function countOthersWeighted(clickArr, id) {
	let n = 0;
	for (let j = 0; j < clickArr.length; j++) if (clickArr[j][0] != id && clickArr[j][1] > 0) n++;
	return n;
}
function setReceivingList(containerId, dataAttr, activeId, clickArr, on) {
	document.querySelectorAll('#' + containerId + ' .lineItem').forEach(function(el) {
		let elId = el.dataset[dataAttr];
		let weighted = false;
		for (let j = 0; j < clickArr.length; j++) if (clickArr[j][0] == elId && clickArr[j][1] > 0) { weighted = true; break; }
		el.classList.toggle('receiving', on && elId != activeId && weighted);
	});
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
		// pointerdown (not click) so we can distinguish a tap from a press-and-
		// hold: the press fires one increment immediately, then holding ramps up
		// additional increments via startHold(). Using pointer events unifies
		// mouse and touch and avoids the trailing synthetic-click double-count.
			containers[i].addEventListener("pointerdown", function(evt) {
				if (!evt.isPrimary) return;                                  // ignore secondary touches
				if (evt.pointerType === 'mouse' && evt.button !== 0) return; // primary button only
				let type = this.dataset.containerId;
				if (type == undefined) return;
				let ring = evt.target.closest('.wrapper');   // the ring is the whole hit target
				if (!ring) return;
				let line = ring.closest('.lineItem');
				if (!line) return;

				let up = null, down = null, canReduce = null, receiving = null;

				if (type === 'phrasing') {
						if (!document.querySelector('#phrasing .endorse')) return;   // must accept the argument to weigh in
					if (sectionState.phrasing.mode === 'idle') {
						sectionState.phrasing.mode = 'editing';
						document.getElementById('phrasing').classList.add('edit');
						let endorseEl = document.querySelector('#phrasing .endorse');
						let resetEl   = document.querySelector('#phrasing .reset');
						if (endorseEl) endorseEl.classList.remove('hidden');
						if (resetEl)   resetEl.classList.remove('hidden');
						neutralizeSection('phrasing');
					}
					let pid = line.dataset.phrasingId;
					up = function() { bumpPhrasing(pid); };
					down = function() { reducePhrasingOthers(pid); };
					canReduce = function() { return countOthersWeighted(phrasingClickArr, pid) > 0; };
					receiving = function(on) { setReceivingList('phrasing', 'phrasingId', pid, phrasingClickArr, on); };
				} else if (type === 'explication') {
						if (!document.querySelector('#explication .endorse')) return;   // must accept the argument to weigh in
					if (sectionState.explication.mode === 'idle') {
						sectionState.explication.mode = 'editing';
						document.getElementById('explication').classList.add('edit');
						let endorseEl = document.querySelector('#explication .endorse');
						let resetEl   = document.querySelector('#explication .reset');
						if (endorseEl) endorseEl.classList.remove('hidden');
						if (resetEl)   resetEl.classList.remove('hidden');
						neutralizeSection('explication');
					}
					let eid = line.dataset.explicationId;
					up = function() { bumpExplication(eid); };
					down = function() { reduceExplicationOthers(eid); };
					canReduce = function() { return countOthersWeighted(explicClickArr, eid) > 0; };
					receiving = function(on) { setReceivingList('explication', 'explicationId', eid, explicClickArr, on); };
				} else {
					// because/therefore/rebuttal — require an unlocked section
					let lockIcon = document.querySelector(`#${type} .section-lock`);
					if (!lockIcon || !lockIcon.classList.contains('unlocked')) return;
					let state = sectionState[type];
					if (!state) return;
					if (state.mode === 'idle') {
						// First press in this section — enter edit mode
						state.mode = 'editing';
						document.getElementById(type).classList.add('edit');
						let endorseEl = document.querySelector(`#${type} .endorse`);
						let resetEl   = document.querySelector(`#${type} .reset`);
						let myWtsEl   = document.querySelector(`#${type} .myWeights`);
						if (endorseEl) endorseEl.classList.remove('hidden');
						if (resetEl)   resetEl.classList.remove('hidden');
						if (myWtsEl)   myWtsEl.classList.remove('hidden');
						neutralizeSection(type);
					}
					let aid = line.dataset.argId;
					up = function() { bump(type, aid); };
					down = function() { reduceOthers(type, aid); };
					canReduce = function() { return countOthersWeighted(state.clickArr, aid) > 0; };
					receiving = function(on) { setReceivingList(type, 'argId', aid, state.clickArr, on); };
				}

				if (!up) return;

				// Own the whole hold: block selection/scroll and capture the pointer
				// so finger drift up/down drives the joystick instead of scrolling.
				evt.preventDefault();
				try { ring.setPointerCapture(evt.pointerId); } catch (e) {}

				up(); // the press counts as one add (tap = +1)
				startHold({ ring: ring, line: line, originY: evt.clientY,
				            up: up, down: down, canReduce: canReduce, receiving: receiving });
			});
	}
	// reset button — neutralize circles and clear click state
	let resets = document.querySelectorAll(".reset");
	limit = resets.length;
	for (i = 0; i < limit; i++) {
		resets[i].addEventListener("click", function(evt) {
			neutralizeSection(this.dataset.containerId);
		});
	}
	// myWeights button — load the user's prior saved weights so they can refine from there
	let myWeightsBtns = document.querySelectorAll(".myWeights");
	limit = myWeightsBtns.length;
	for (i = 0; i < limit; i++) {
		myWeightsBtns[i].addEventListener("click", function(evt) {
			let id = this.dataset.containerId;
			neutralizeSection(id);
			loadUserWeights(id);
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

	// Header phrasing: when the text is clamped/overflowing, reveal a "(more)"
	// link that opens the phrasing modal so the full text is reachable.
	let argPhrasingEl = document.querySelector(".arg-phrasing");
	let phrasingMore  = document.querySelector(".arg-phrasing-more");
	if (argPhrasingEl && phrasingMore) {
		if (argPhrasingEl.scrollHeight > argPhrasingEl.clientHeight + 2) {
			phrasingMore.classList.remove("hidden");
		}
		phrasingMore.addEventListener("click", function(evt) {
			evt.preventDefault();
			if (overlayP && putforth) {
				overlayP.classList.toggle("hidden");
				putforth.classList.toggle("hidden");
			}
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

	// ── Flag modal ───────────────────────────────────────────────────────────
	let overlayF  = document.getElementById("overlayF");
	let flagModal = document.getElementById("flagModal");
	let openFlag  = document.querySelector(".flagBtn");   // <button> when logged in, <a> when not
	let closeF    = document.getElementById("closeF");
	function toggleFlagModal() {
		if (overlayF)  overlayF.classList.toggle("hidden");
		if (flagModal) flagModal.classList.toggle("hidden");
	}
	if (openFlag && openFlag.tagName === "BUTTON") {
		openFlag.addEventListener("click", toggleFlagModal);
	}
	if (closeF) closeF.addEventListener("click", toggleFlagModal);
	if (overlayF) {
		overlayF.addEventListener("click", function(evt) {
			if (evt.target === overlayF) toggleFlagModal();   // click backdrop to close
		});
	}
	// "Other" requires a comment; also block submitting with no reason chosen
	let flagForm = document.getElementById("flagForm");
	if (flagForm) {
		flagForm.addEventListener("submit", function(evt) {
			if (evt.submitter && evt.submitter.value === "unflagArgument") return; // removing — skip validation
			let cat = flagForm.querySelector('input[name="flagCategory"]:checked');
			let cmt = document.getElementById("flagComment");
			let err = document.getElementById("flagError");
			if (!cat) {
				evt.preventDefault();
				if (err) { err.textContent = "Please choose a reason."; err.classList.remove("hidden"); }
				return;
			}
			if (cat.value === "other" && cmt && cmt.value.trim() === "") {
				evt.preventDefault();
				if (err) { err.textContent = "Please add a comment explaining the issue."; err.classList.remove("hidden"); }
				return;
			}
		});
	}

	// ── Explication carousel ────────────────────────────────────────────────
	document.querySelectorAll('.carousel-box').forEach(function(box) {
		var track = box.querySelector('.carousel-track');
		if (!track) return;                                  // 0 links — nothing to do

		var inner   = track.querySelector('.carousel-slides');
		var slides  = inner ? inner.querySelectorAll('.carousel-slide') : [];
		var total   = slides.length;
		if (total <= 1) return;                              // 1 link — no nav needed

		var prevBtn  = box.querySelector('.carousel-prev');
		var nextBtn  = box.querySelector('.carousel-next');
		var dotsEl   = box.querySelector('.carousel-dots');
		var current  = 0;
		var dots     = [];

		// Size the track to the visible slide so short slides don't inherit the
		// tallest slide's height (which left a gap above the nav arrows).
		function fit() {
			if (slides[current]) track.style.height = slides[current].offsetHeight + 'px';
		}

		function goTo(n) {
			current = ((n % total) + total) % total;
			inner.style.transform = 'translateX(-' + (current * 100) + '%)';
			for (var k = 0; k < dots.length; k++) dots[k].classList.toggle('on', k === current);
			fit();
		}

		track.classList.add('carousel-ready');   // reveal the other slides now that JS sizes the track
		if (dotsEl) {
			for (var di = 0; di < total; di++) {
				var dot = document.createElement('span');
				dot.className = 'dot';
				(function (idx) { dot.addEventListener('click', function () { goTo(idx); }); })(di);
				dotsEl.appendChild(dot);
				dots.push(dot);
			}
		}
		goTo(0);
		window.addEventListener('resize', fit);

		if (prevBtn) prevBtn.addEventListener('click', function() { goTo(current - 1); });
		if (nextBtn) nextBtn.addEventListener('click', function() { goTo(current + 1); });

		// Touch / swipe — horizontal gesture navigates; tap falls through to the link
		var touchStartX = 0;
		var touchStartY = 0;
		var swipeFired  = false;

		track.addEventListener('touchstart', function(e) {
			touchStartX = e.touches[0].clientX;
			touchStartY = e.touches[0].clientY;
			swipeFired  = false;
		}, { passive: true });

		// Claim horizontal moves early so the browser never scrolls overflowed content
		track.addEventListener('touchmove', function(e) {
			var dx = e.touches[0].clientX - touchStartX;
			var dy = e.touches[0].clientY - touchStartY;
			if (Math.abs(dx) > Math.abs(dy)) {
				e.preventDefault();
			}
		}, { passive: false });

		track.addEventListener('touchend', function(e) {
			var dx = e.changedTouches[0].clientX - touchStartX;
			var dy = e.changedTouches[0].clientY - touchStartY;
			if (Math.abs(dx) > 40 && Math.abs(dx) > Math.abs(dy)) {
				swipeFired = true;
				e.preventDefault();                          // suppress the follow-on click
				goTo(dx < 0 ? current + 1 : current - 1);
			}
		}, { passive: false });

		// Belt-and-suspenders: swallow click if a swipe just happened
		track.addEventListener('click', function(e) {
			if (swipeFired) { e.preventDefault(); swipeFired = false; }
		}, true);
	});


	// ─── Form validation helpers ────────────────────────────────────────────────
	function showValidationError(el, msg) {
		el.textContent = msg;
		el.classList.remove('hidden');
	}
	function clearValidationError(el) {
		el.textContent = '';
		el.classList.add('hidden');
	}
	// True if the string looks like a URL rather than human prose
	function isLikelyUrl(str) {
		if (/^https?:\/\//i.test(str)) return true;  // explicit protocol
		if (/^www\./i.test(str))        return true;  // www. prefix
		// No spaces + contains a dot + ends or continues like a path → bare domain
		if (!/\s/.test(str) && /\.[a-z]{2,}(\/|$)/i.test(str)) return true;
		return false;
	}
	function containsHtml(str) {
		return /<[a-zA-Z][^>]*>/i.test(str);
	}
	function hasLetters(str) {
		return /[a-zA-ZÀ-ɏ]/.test(str);
	}

	// ─── Phrasing form ───────────────────────────────────────────────────────
	let phrasingForm  = document.querySelector('#phrasing .assert form');
	let phrasingInput = document.getElementById('newPutForthInput');
	let phrasingError = document.getElementById('phrasingError');

	if (phrasingForm && phrasingInput && phrasingError) {
		phrasingForm.addEventListener('submit', function(evt) {
			let val = phrasingInput.value.trim();
			clearValidationError(phrasingError);
			if (!val || val.length < 5) {
				evt.preventDefault();
				showValidationError(phrasingError, 'Too short — write it out as a complete sentence.');
			} else if (val.length > 300) {
				evt.preventDefault();
				showValidationError(phrasingError, 'Phrasing must be 300 characters or less.');
			} else if (isLikelyUrl(val)) {
				evt.preventDefault();
				showValidationError(phrasingError, 'Phrasings should be readable text, not a URL. Add links in the Explication section.');
			} else if (containsHtml(val)) {
				evt.preventDefault();
				showValidationError(phrasingError, 'HTML tags are not allowed in phrasings.');
			} else if (!hasLetters(val)) {
				evt.preventDefault();
				showValidationError(phrasingError, 'Phrasings must contain readable text with letters.');
			}
		});
		phrasingInput.addEventListener('input', function() { clearValidationError(phrasingError); });
	}

	// ─── Explication form ────────────────────────────────────────────────────
	let explicForm  = document.querySelector('#explication .assert form');
	let explicInput = document.getElementById('promoteExplicationInput');
	let explicError = document.getElementById('explicError');

	if (explicForm && explicInput && explicError) {
		explicForm.addEventListener('submit', function(evt) {
			let val = explicInput.value.trim();
			clearValidationError(explicError);
			if (!val) {
				evt.preventDefault();
				showValidationError(explicError, 'Please enter a URL.');
			} else if (!/^https?:\/\//i.test(val)) {
				evt.preventDefault();
				showValidationError(explicError, 'Must be a full URL starting with https:// or http://');
			} else {
				try { new URL(val); }
				catch(e) {
					evt.preventDefault();
					showValidationError(explicError, 'That doesn\'t look like a valid URL.');
				}
			}
		});
		explicInput.addEventListener('input', function() { clearValidationError(explicError); });
	}

	// ─── Find sub-section accordion ──────────────────────────────────────────
	// Only one sub-section open at a time. Clicking a collapsed header opens it
	// and closes the others; clicking the open header collapses it (none open).
	document.querySelectorAll('.find-toggle').forEach(function(toggle) {
		toggle.addEventListener('click', function() {
			let content = this.nextElementSibling;
			if (!content) return;
			let wasCollapsed = content.classList.contains('collapsed');
			// Collapse every sub-section first
			document.querySelectorAll('#find .find-content').forEach(function(c) {
				c.classList.add('collapsed');
			});
			document.querySelectorAll('#find .find-toggle').forEach(function(t) {
				t.classList.add('collapsed');
			});
			// If the clicked one was collapsed, open it (others remain collapsed)
			if (wasCollapsed) {
				content.classList.remove('collapsed');
				this.classList.remove('collapsed');
				// Remember the choice so it re-opens on the next argument page
				try { localStorage.setItem('findOpenKey', this.dataset.findKey || ''); } catch (e) {}
				// Lazy-load the neighborhood list the first time it's opened
				if (content.id === 'neighborhoodContent' && content.dataset.loaded === '0') {
					content.dataset.loaded = '1';
					fetch('/neighborhood.php?arg=' + encodeURIComponent(content.dataset.arg))
						.then(function(r) { return r.text(); })
						.then(function(html) { content.innerHTML = html; })
						.catch(function() {
							content.dataset.loaded = '0';
							content.innerHTML = '<ul><li class="lineItem"><span class="find-loading">Could not load — try again.</span></li></ul>';
						});
				}
			} else {
				// Clicked the open header to close it — nothing is open now
				try { localStorage.removeItem('findOpenKey'); } catch (e) {}
			}
		});
	});

	// Restore the user's last-opened Find subsection (persists across argument pages)
	try {
		let savedFindKey = localStorage.getItem('findOpenKey');
		if (savedFindKey) {
			let savedToggle = document.querySelector('#find .find-toggle[data-find-key="' + savedFindKey + '"]');
			if (savedToggle) savedToggle.click();
		}
	} catch (e) {}

	// ── Find/Filter desktop accordion pair ──────────────────────────────────
	(function() {
		var findEl = document.getElementById('find');
		var filterEl = document.getElementById('filter');
		if (!findEl) return;

		var isDesktop = function() { return window.innerWidth >= 1200; };

		function applyDesktopState(openFilter) {
			if (!isDesktop()) return;
			if (!filterEl) {
				findEl.classList.add('desktop-expanded');
				return;
			}
			if (openFilter) {
				findEl.classList.remove('desktop-expanded');
				filterEl.classList.add('desktop-expanded');
			} else {
				findEl.classList.add('desktop-expanded');
				filterEl.classList.remove('desktop-expanded');
			}
		}

		var savedPanel = null;
		try { savedPanel = localStorage.getItem('filterPanelOpen'); } catch (e) {}
		applyDesktopState(savedPanel === '1');
		if (!savedPanel && isDesktop()) findEl.classList.add('desktop-expanded');

		var findH2 = findEl.querySelector('h2');
		if (findH2) {
			findH2.addEventListener('click', function(e) {
				if (!isDesktop()) return;
				e.stopPropagation();
				applyDesktopState(false);
				try { localStorage.setItem('filterPanelOpen', '0'); } catch (e) {}
			});
		}

		if (filterEl) {
			var filterH2 = filterEl.querySelector('h2');
			if (filterH2) {
				filterH2.addEventListener('click', function(e) {
					if (!isDesktop()) return;
					e.stopPropagation();
					applyDesktopState(true);
					try { localStorage.setItem('filterPanelOpen', '1'); } catch (e) {}
				});
			}
		}

		window.addEventListener('resize', function() {
			if (isDesktop()) {
				var open = null;
				try { open = localStorage.getItem('filterPanelOpen'); } catch (e) {}
				applyDesktopState(open === '1');
				if (!open) findEl.classList.add('desktop-expanded');
			} else {
				if (findEl) findEl.classList.remove('desktop-expanded');
				if (filterEl) filterEl.classList.remove('desktop-expanded');
			}
		});
	})();

	// ── Filter Options overlay (open / close) ───────────────────────────────
	(function() {
		var openBtn = document.getElementById('openFilterOverlay');
		var overlay = document.getElementById('overlayFilter');
		var closeBtn = document.getElementById('closeFilter');
		if (!openBtn || !overlay) return;

		openBtn.addEventListener('click', function(e) {
			e.preventDefault();
			overlay.classList.remove('hidden');
			var input = overlay.querySelector('#affiliationSearch');
			if (input) setTimeout(function() { input.focus(); }, 100);
		});

		if (closeBtn) {
			closeBtn.addEventListener('click', function() {
				overlay.classList.add('hidden');
			});
		}

		overlay.addEventListener('click', function(e) {
			if (e.target === overlay) overlay.classList.add('hidden');
		});
	})();

	// ── Find header search button + overlay (open / close) ──────────────────
	(function() {
		var openBtn = document.getElementById('openSearchOverlay');
		var overlay = document.getElementById('overlaySearch');
		var closeBtn = document.getElementById('closeSearch');
		if (!openBtn || !overlay) return;

		openBtn.addEventListener('click', function(e) {
			// Only act as a search button — the header's own click area still
			// handles accordion expand/collapse (and the desktop Find/Filter
			// toggle), so this click must never bubble up into either.
			e.preventDefault();
			e.stopPropagation();
			overlay.classList.remove('hidden');
			var input = overlay.querySelector('#indexSearchInput');
			if (input) setTimeout(function() { input.focus(); }, 100);
		});

		if (closeBtn) {
			closeBtn.addEventListener('click', function() {
				overlay.classList.add('hidden');
			});
		}

		overlay.addEventListener('click', function(e) {
			if (e.target === overlay) overlay.classList.add('hidden');
		});
	})();

	// ── Index page site-wide search (AJAX, inside overlay) ──────────────────
	(function() {
		var searchInput = document.getElementById('indexSearchInput');
		var resultsList = document.getElementById('indexSearchResults');
		if (!searchInput || !resultsList) return;

		var debounceTimer = null;

		searchInput.addEventListener('input', function() {
			clearTimeout(debounceTimer);
			var q = searchInput.value.trim();
			if (q.length < 3) { resultsList.innerHTML = ''; return; }
			debounceTimer = setTimeout(function() {
				var fd = new FormData();
				fd.append('q', q);
				fd.append('mode', 'explore');
				fetch('/find_similar.php', { method: 'POST', body: fd })
					.then(function(r) { return r.json(); })
					.then(function(matches) {
						resultsList.innerHTML = '';
						if (!matches.length) {
							var li = document.createElement('li');
							li.className = 'explore-search-empty';
							li.textContent = 'No matches found.';
							resultsList.appendChild(li);
							return;
						}
						matches.forEach(function(m) {
							var li = document.createElement('li');
							li.className = 'explore-item';
							var a = document.createElement('a');
							a.href = '/?arg=' + m.argID;
							a.textContent = m.phrasing || '(untitled)';
							li.appendChild(a);
							resultsList.appendChild(li);
						});
					});
			}, 300);
		});
	})();

	// ── Affiliation search (AJAX, inside overlay) ───────────────────────────
	(function() {
		var searchInput = document.getElementById('affiliationSearch');
		var resultsList = document.getElementById('affiliationResults');
		if (!searchInput || !resultsList) return;

		var debounceTimer = null;

		searchInput.addEventListener('input', function() {
			clearTimeout(debounceTimer);
			var q = searchInput.value.trim();
			if (q.length < 2) {
				resultsList.innerHTML = '';
				return;
			}
			debounceTimer = setTimeout(function() {
				var fd = new FormData();
				fd.append('q', q);
				fetch('/search_affiliations.php', { method: 'POST', body: fd })
					.then(function(r) { return r.json(); })
					.then(function(matches) {
						resultsList.innerHTML = '';
						matches.forEach(function(m) {
							var li = document.createElement('li');
							li.textContent = m.orgName;
							li.addEventListener('click', function() {
								var form = document.createElement('form');
								form.method = 'POST';
								form.action = '/?arg=' + (typeof arg !== 'undefined' ? arg : '');
								var inp1 = document.createElement('input');
								inp1.type = 'hidden'; inp1.name = 'buttonClicked'; inp1.value = 'addAffiliationFilter';
								var inp2 = document.createElement('input');
								inp2.type = 'hidden'; inp2.name = 'affiliationID'; inp2.value = m.affiliationID;
								var inp3 = document.createElement('input');
								inp3.type = 'hidden'; inp3.name = 'csrfToken';
								inp3.value = typeof csrfToken !== 'undefined' ? csrfToken : '';
								form.appendChild(inp1);
								form.appendChild(inp2);
								form.appendChild(inp3);
								document.body.appendChild(form);
								form.submit();
							});
							resultsList.appendChild(li);
						});
					})
					.catch(function() { resultsList.innerHTML = ''; });
			}, 300);
		});
	})();


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

	// ── Demo mode: suppress iOS scroll-to-focus jumps ───────────────────────
	if (typeof demoMode !== 'undefined' && demoMode) {
		document.querySelectorAll('input, textarea, select').forEach(function(el) {
			el.addEventListener('focus', function() {
				var sx = window.scrollX, sy = window.scrollY;
				setTimeout(function() { window.scrollTo(sx, sy); }, 0);
			});
		});
	}
}


/*
Restore user's previously-saved weights into the section's visual display and
click-state, so they can start adjusting from their prior endorsement rather
than from scratch.  Called by the myWeights (avatar) button.
*/
function loadUserWeights(id) {
	if (DEBUG) console.log(`loadUserWeights: id: ${id}`);
	let args = document.querySelectorAll(`#${id} .lineItem`);
	let limit = args.length;
	for (let i = 0; i < limit; i++) {
		let weight = parseFloat(args[i].dataset.userWeight);
		if (DEBUG) console.log(`loadUserWeights: item ${i} weight=${weight}`);
		if (weight > 0) {
			paintLine(args[i], weight);
		}
	}

	if (id === 'phrasing') { updatePhrasingWeighInValue(); return; }
	if (id === 'explication') { updateExplicationWeighInValue(); return; }

	// Reconstruct the click array from the user's saved weights so subsequent
	// circle clicks adjust proportionally from the loaded baseline.
	let rawArr;
	switch (id) {
		case 'because':   rawArr = because;   break;
		case 'therefore': rawArr = therefore; break;
		case 'rebuttal':  rawArr = rebuttal;  break;
		default: rawArr = null;
	}

	if (rawArr && sectionState[id]) {
		// Filter to items with a positive user weight; null/0 entries are skipped.
		let weighted = rawArr.filter(row => row && row[3] != null && parseFloat(row[3]) > 0);
		if (weighted.length > 0) {
			let clickArr = pctToClicks(weighted, 3);
			sectionState[id].clickArr.length = 0;
			sectionState[id].totalClicks = 0;
			for (let i = 0; i < clickArr.length; i++) {
				sectionState[id].clickArr.push([clickArr[i][0], clickArr[i][1]]);
				sectionState[id].totalClicks += clickArr[i][1];
			}
			if (DEBUG) console.log(`loadUserWeights: loaded ${clickArr.length} items into sectionState[${id}]`);
		}
	}
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
Record a click on argID within the given section type and update the display.
Uses per-section sectionState to prevent cross-section contamination.
*/
// Clicks a brand-new item should enter the weighting with. Normally 1, but once
// the existing total is large enough that a single click would be worth < 1% of
// the resulting total, we seed it with the minimum clicks needed to clear 1% so
// it never enters as an unreachable sliver. `others` = clicks already in play.
//   1 click < 1%  ⇔  1/(others+1) < 0.01  ⇔  others > 99
//   min clicks nc for nc/(others+nc) >= 1%  ⇔  nc >= others/99  ⇔  ceil(others/99)
function floorClicksForNew(others) {
	if (others <= 0) return 1;
	return Math.max(1, Math.ceil(others / 99));
}

function bump(type, argID) {
	let state = sectionState[type];
	if (!state) return;
	let ndx = state.clickArr.findIndex((tuple) => tuple[0] == argID);
	if (ndx >= 0) {
		state.clickArr[ndx][1] += 1;
		state.totalClicks += 1;
	} else {
		let nc = floorClicksForNew(state.totalClicks);
		state.clickArr.push([argID, nc]);
		state.totalClicks += nc;
	}
	renderSection(type);
}

// Reduce = raise every OTHER weighted argument, so the held one's share falls
// while its own click count stays put. A no-op if nothing else carries weight.
// Reduce an argument's share, two-phase:
//   1. While it still has more than 1 click, take a click off it (and the total)
//      — the cheap, direct way to shrink its share.
//   2. Once it bottoms out at 1 click, switch to raising every OTHER weighted
//      argument instead, so the denominator grows and its share keeps falling
//      without ever dropping the argument below a single click.
function reduceOthers(type, argID) {
	let state = sectionState[type];
	if (!state) return;
	let ndx = state.clickArr.findIndex((tuple) => tuple[0] == argID);
	if (ndx >= 0 && state.clickArr[ndx][1] > 1) {
		state.clickArr[ndx][1] -= 1;
		state.totalClicks -= 1;
		renderSection(type);
		return;
	}
	let raised = false;
	for (let j = 0; j < state.clickArr.length; j++) {
		if (state.clickArr[j][0] != argID && state.clickArr[j][1] > 0) {
			state.clickArr[j][1] += 1;
			state.totalClicks++;
			raised = true;
		}
	}
	if (raised) renderSection(type);
}

function renderSection(type) {
	let state = sectionState[type];
	if (!state) return;
	document.querySelectorAll(`#${type} .lineItem`).forEach(function(el) {
		let value = 0;
		for (let j = 0; j < state.clickArr.length; j++) {
			if (state.clickArr[j][0] == el.dataset.argId) { value = state.clickArr[j][1]; break; }
		}
		paintLine(el, state.totalClicks > 0 ? (value / state.totalClicks) * 100 : 0);
	});
	updateWeighInValue(type);
}

function bumpPhrasing(phrasingID) {
	let ndx = phrasingClickArr.findIndex((tuple) => tuple[0] == phrasingID);
	if (ndx >= 0) {
		phrasingClickArr[ndx][1] += 1;
		phrasingTotalClicks += 1;
	} else {
		let nc = floorClicksForNew(phrasingTotalClicks);
		phrasingClickArr.push([phrasingID, nc]);
		phrasingTotalClicks += nc;
	}
	renderPhrasing();
}

function reducePhrasingOthers(phrasingID) {
	let ndx = phrasingClickArr.findIndex((tuple) => tuple[0] == phrasingID);
	if (ndx >= 0 && phrasingClickArr[ndx][1] > 1) {
		phrasingClickArr[ndx][1] -= 1;
		phrasingTotalClicks -= 1;
		renderPhrasing();
		return;
	}
	let raised = false;
	for (let j = 0; j < phrasingClickArr.length; j++) {
		if (phrasingClickArr[j][0] != phrasingID && phrasingClickArr[j][1] > 0) {
			phrasingClickArr[j][1] += 1;
			phrasingTotalClicks++;
			raised = true;
		}
	}
	if (raised) renderPhrasing();
}

function renderPhrasing() {
	document.querySelectorAll('#phrasing .lineItem').forEach(function(el) {
		let value = 0;
		for (let j = 0; j < phrasingClickArr.length; j++) {
			if (phrasingClickArr[j][0] == el.dataset.phrasingId) { value = phrasingClickArr[j][1]; break; }
		}
		paintLine(el, phrasingTotalClicks > 0 ? (value / phrasingTotalClicks) * 100 : 0);
	});
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
	let ndx = explicClickArr.findIndex((tuple) => tuple[0] == explicationID);
	if (ndx >= 0) {
		explicClickArr[ndx][1] += 1;
		explicTotalClicks += 1;
	} else {
		let nc = floorClicksForNew(explicTotalClicks);
		explicClickArr.push([explicationID, nc]);
		explicTotalClicks += nc;
	}
	renderExplication();
}

function reduceExplicationOthers(explicationID) {
	let ndx = explicClickArr.findIndex((tuple) => tuple[0] == explicationID);
	if (ndx >= 0 && explicClickArr[ndx][1] > 1) {
		explicClickArr[ndx][1] -= 1;
		explicTotalClicks -= 1;
		renderExplication();
		return;
	}
	let raised = false;
	for (let j = 0; j < explicClickArr.length; j++) {
		if (explicClickArr[j][0] != explicationID && explicClickArr[j][1] > 0) {
			explicClickArr[j][1] += 1;
			explicTotalClicks++;
			raised = true;
		}
	}
	if (raised) renderExplication();
}

function renderExplication() {
	document.querySelectorAll('#explication .lineItem').forEach(function(el) {
		let value = 0;
		for (let j = 0; j < explicClickArr.length; j++) {
			if (explicClickArr[j][0] == el.dataset.explicationId) { value = explicClickArr[j][1]; break; }
		}
		paintLine(el, explicTotalClicks > 0 ? (value / explicTotalClicks) * 100 : 0);
	});
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

	// On desktop, Find/Filter use their own desktop-expanded toggle — skip here
	if (window.innerWidth >= 1200 && (this.id === 'find' || this.id === 'filter')) return;

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
	// (Removed the old "grow main phrasing" logic — the phrasing now lives in the
	// header with a fixed size, and the panel <p> is carousel/helper text that must
	// not be resized.)
}


/*
Initialize after DOM content is loaded.
*/
document.addEventListener('DOMContentLoaded', function() {
	init();
	resumeIntentPulse();
});

/*
Post-login intent resume: /?arg=N&resume=accept|reject|flag pulses the control
the user was reaching for when they hit the login wall, then strips the param
so a refresh doesn't re-pulse.
*/
function resumeIntentPulse() {
	let params = new URLSearchParams(window.location.search);
	let resume = params.get('resume');
	if (!resume) return;

	let selectors = {
		accept: '.opinion .button.accept',
		reject: '.opinion .button.reject',
		flag:   '.flag-row .flagBtn'
	};
	let el = selectors[resume] ? document.querySelector(selectors[resume]) : null;
	if (el) {
		el.scrollIntoView({ block: 'center' });
		el.classList.add('resume-pulse');
		el.addEventListener('animationend', function() {
			el.classList.remove('resume-pulse');
		}, { once: true });
	}

	params.delete('resume');
	let qs = params.toString();
	history.replaceState(null, '', window.location.pathname + (qs ? '?' + qs : '') + window.location.hash);
}

window.addEventListener("orientationchange", function() {
	resize('orientationchange');
});