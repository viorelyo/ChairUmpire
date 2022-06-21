class List {
	const INITIAL_SIZE = 10;

	private var elements;
	private var length;

	function initialize() {
		elements = new [INITIAL_SIZE];
		length = 0;
	}

	function size() {
		return length;
	}

	function isEmpty() {
		return length == 0;
	}

	function get(index) {
		if(index >= length) {
			throw new Toybox.Lang.ValueOutOfBoundsException("Index " + index + " is bigger than list size (" + length + ")");
		}
		return elements[index];
	}

	function indexOf(element) {
		return elements.indexOf(element);
	}

	function remove(element) {
		length--;
		return elements.remove(element);
	}

    function clear() {
        initialize();


        // while (length > 0) {
        //     pop();
        // }

        // length = 0;
    }

	function push(element) {
		if(length + 1 > elements.size()) {
			grow();
		}
		elements[length] = element;
		length++;
	}

	function pop() {
		length--;
		return elements[length];
	}

	function first() {
		if(length == 0) {
			throw new Toybox.Lang.ValueOutOfBoundsException("No first element for an empty list");
		}
		return elements[0];
	}

	function last() {
		if(length == 0) {
			throw new Toybox.Lang.ValueOutOfBoundsException("No last element for an empty list");
		}
		return elements[length - 1];
	}

	hidden function grow() {
		var new_elements = new [elements.size() + INITIAL_SIZE];
		for(var i = 0; i < length; i++) {
			new_elements[i] = elements[i];
		}
		elements = new_elements;
	}
}
