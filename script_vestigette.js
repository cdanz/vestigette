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
			if (type == undefined) return;
			if (!evt.target.classList.contains('pointBtn')) return;
			if (!inCircle(evt, evt.target)) return;

			if (type === 'phrasing') {
				if (DEBUG) console.log(`in circle phrasing ${evt.target.parentNode.parentNode.dataset.phrasingId}`);
				if (sectionState.phrasing.mode === 'idle') {
					sectionState.phrasing.mode = 'editing';
					document.getElementById('phrasing').classList.add('edit');
					let endorseEl = document.querySelector('#phrasing .endorse');
					let resetEl   = document.querySelector('#phrasing .reset');
					if (endorseEl) endorseEl.classList.remove('hidden');
					if (resetEl)   resetEl.classList.remove('hidden');
					neutralizeSection('phrasing');
				}
				bumpPhrasing(evt.target.parentNode.parentNode.dataset.phrasingId);
				return;
			}
			if (type === 'explication') {
				if (DEBUG) console.log(`in circle explication ${evt.target.parentNode.parentNode.dataset.explicationId}`);
				if (sectionState.explication.mode === 'idle') {
					sectionState.explication.mode = 'editing';
					document.getElementById('explication').classList.add('edit');
					let endorseEl = document.querySelector('#explication .endorse');
					let resetEl   = document.querySelector('#explication .reset');
					if (endorseEl) endorseEl.classList.remove('hidden');
					if (resetEl)   resetEl.classList.remove('hidden');
					neutralizeSection('explication');
				}
				bumpExplication(evt.target.parentNode.parentNode.dataset.explicationId);
				return;
			}

			// For because/therefore/rebuttal: check if section is unlocked
			let lockIcon = document.querySelector(`#${type} .section-lock`);
			if (!lockIcon || !lockIcon.classList.contains('unlocked')) return;

			let state = sectionState[type];
			if (state.mode === 'idle') {
				// First click in this section — enter edit mode
				state.mode = 'editing';
				document.getElementById(type).classList.add('edit');
				// Reveal endorse, reset, and myWeights buttons
				let endorseEl = document.querySelector(`#${type} .endorse`);
				let resetEl   = document.querySelector(`#${type} .reset`);
				let myWtsEl   = document.querySelector(`#${type} .myWeights`);
				if (endorseEl) endorseEl.classList.remove('hidden');
				if (resetEl)   resetEl.classList.remove('hidden');
				if (myWtsEl)   myWtsEl.classList.remove('hidden');
				// Reset all circle weights to zero (fresh start from scratch)
				neutralizeSection(type);
			}

			if (DEBUG) console.log(`in circle ${evt.target.parentNode.nextElementSibling.children[0].innerHTML}`);
			bump(type, evt.target.parentNode.parentNode.dataset.argId);
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
		var countEl  = box.querySelector('.carousel-count');
		var label    = countEl ? (countEl.dataset.label || '') : '';
		var current  = 0;

		// Size the track to the visible slide so short slides don't inherit the
		// tallest slide's height (which left a gap above the nav arrows).
		function fit() {
			if (slides[current]) track.style.height = slides[current].offsetHeight + 'px';
		}

		function goTo(n) {
			current = ((n % total) + total) % total;
			inner.style.transform = 'translateX(-' + (current * 100) + '%)';
			if (countEl) countEl.textContent = (current + 1) + ' of ' + total + (label ? ' ' + label : '');
			fit();
		}

		fit();
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
			let pct = getExistingPct(args[i]);
			let newpct = getPctClass(weight);
			if (DEBUG) console.log(`loadUserWeights: applying ${newpct}`);
			args[i].classList.remove("half1", "half2", pct);
			args[i].classList.add(weight <= 50 ? "half1" : "half2");
			args[i].classList.add(newpct);
			setInlinePct(args[i], weight);
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
function bump(type, argID) {
	let state = sectionState[type];
	if (!state) return;

	state.totalClicks++;
	let ndx = state.clickArr.findIndex((tuple) => tuple[0] == argID);
	if (ndx >= 0) {
		state.clickArr[ndx][1] += 1;
	} else {
		state.clickArr.push([argID, 1]);
	}

	let args = document.querySelectorAll(`#${type} .lineItem`);
	let limit = args.length;
	for (let i = 0; i < limit; i++) {
		let value = 0;
		for (let j = 0; j < state.clickArr.length; j++) {
			if (state.clickArr[j][0] == args[i].dataset.argId) {
				value = state.clickArr[j][1];
				break;
			}
		}
		if (value > 0) {
			let rate = (value / state.totalClicks) * 100;
			let pct = getExistingPct(args[i]);
			let newpct = getPctClass(rate);
			args[i].classList.remove("half1", "half2", pct);
			args[i].classList.add(rate <= 50 ? "half1" : "half2");
			if (DEBUG) console.log(`bump: adding ${newpct}...`);
			args[i].classList.add(newpct);
			setInlinePct(args[i], rate);
		}
	}
	if (DEBUG) console.log(`bump: sectionState[${type}].clickArr`, state.clickArr);
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