/* Polyfill service v3.19.0
 * For detailed credits and licence information see https://github.com/financial-times/polyfill-service.
 * 
 * UA detected: firefox/47.0.0
 * Features requested: default
 * 
 * - _mutation, License: CC0 (required by "Element.prototype.after", "default", "Element.prototype.append", "Element.prototype.before", "Element.prototype.prepend", "Element.prototype.replaceWith")
 * - Element.prototype.after, License: CC0 (required by "default")
 * - Element.prototype.append, License: CC0 (required by "default")
 * - Element.prototype.before, License: CC0 (required by "default")
 * - Element.prototype.prepend, License: CC0 (required by "default")
 * - Element.prototype.replaceWith, License: CC0 (required by "default")
 * - Event.focusin, License: CC0 (required by "default")
 * - Event.hashchange, License: CC0 (required by "default") */

(function(undefined) {

// _mutation
// http://dom.spec.whatwg.org/#mutation-method-macro
function _mutation(nodes) { // eslint-disable-line no-unused-vars
	if (!nodes.length) {
		throw new Error('DOM Exception 8');
	} else if (nodes.length === 1) {
		return typeof nodes[0] === 'string' ? document.createTextNode(nodes[0]) : nodes[0];
	} else {
		var
		fragment = document.createDocumentFragment(),
		length = nodes.length,
		index = -1,
		node;

		while (++index < length) {
			node = nodes[index];

			fragment.appendChild(typeof node === 'string' ? document.createTextNode(node) : node);
		}

		return fragment;
	}
}

// Element.prototype.after
Document.prototype.after = Element.prototype.after = function after() {
	if (this.parentNode) {
		this.parentNode.insertBefore(_mutation(arguments), this.nextSibling);
	}
};

// Not all UAs support the Text constructor.  Polyfill on the Text constructor only where it exists
// TODO: Add a polyfill for the Text constructor, and make it a dependency of this polyfill.
if ("Text" in this) {
	Text.prototype.after = Element.prototype.after;
}

// Element.prototype.append
Document.prototype.append = Element.prototype.append = function append() {
	this.appendChild(_mutation(arguments));
};

// Element.prototype.before
Document.prototype.before = Element.prototype.before = function before() {
	if (this.parentNode) {
		this.parentNode.insertBefore(_mutation(arguments), this);
	}
};

// Not all UAs support the Text constructor.  Polyfill on the Text constructor only where it exists
// TODO: Add a polyfill for the Text constructor, and make it a dependency of this polyfill.
if ("Text" in this) {
	Text.prototype.before = Element.prototype.before;
}

// Element.prototype.prepend
Document.prototype.prepend = Element.prototype.prepend = function prepend() {
	this.insertBefore(_mutation(arguments), this.firstChild);
};

// Element.prototype.replaceWith
Document.prototype.replaceWith = Element.prototype.replaceWith = function replaceWith() {
	if (this.parentNode) {
		this.parentNode.replaceChild(_mutation(arguments), this);
	}
};

// Not all UAs support the Text constructor.  Polyfill on the Text constructor only where it exists
// TODO: Add a polyfill for the Text constructor, and make it a dependency of this polyfill.
if ('Text' in this) {
	Text.prototype.replaceWith = Element.prototype.replaceWith;
}

// Event.focusin
this.addEventListener('focus', function (event) {
	event.target.dispatchEvent(new Event('focusin', {
		bubbles: true,
		cancelable: true
	}));
}, true);

this.addEventListener('blur', function (event) {
	event.target.dispatchEvent(new Event('focusout', {
		bubbles: true,
		cancelable: true
	}));
}, true);

// Event.hashchange
(function (global) {
	var hash = global.location.hash;

	function poll () {
		if (hash !== global.location.hash) {
			hash = global.location.hash;

			global.dispatchEvent(new Event('hashchange'));
		}

		setTimeout(poll, 500);
	};

	// Make sure a check for 'onhashchange' in window will pass (note: setting to undefined IE<9 causes 'Not implemented' error)
	global.onhashchange = function() {};

	poll();
}(this));
})
.call('object' === typeof window && window || 'object' === typeof self && self || 'object' === typeof global && global || {});
