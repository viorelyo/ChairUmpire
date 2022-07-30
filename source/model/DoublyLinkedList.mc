class ListNode {
    var data;
    var next as ListNode;
    var prev as ListNode;

    function initialize(_data) {
        data = _data;
        next = null;
        prev = null;
    }
}

class DoublyLinkedList {

    private var head;
    private var tail;

    private var size;

    function initialize() {
        head = null;
        tail = null;

        size = 0;
    }

    function pushFront(data) {
        var newNode = new ListNode(data);
        newNode.next = head;

        if (head != null) {
            head.prev = newNode;
            head = newNode;
            newNode.prev = null;
        } else {
            head = newNode;
            tail = newNode;
            newNode.prev = null;
        }

        size++;
    }

    function pushBack(data) {
        var newNode = new ListNode(data);
        newNode.prev = tail;

        if (tail != null) {
            tail.next = newNode;
            newNode.next = null;
            tail = newNode;
        } else {
            head = newNode;
            tail = newNode;
            newNode.next = null;
        }

        size++;
    }

    function popFront() {
        if (head == null) {
            throw new Toybox.Lang.ValueOutOfBoundsException("Empty list");
        }

        var temp = head;

        if (temp.next != null) {
            temp.next.prev = null;
        }
        
        head = temp.next;
        temp.next = null;

        size--;

        return temp.data;
    }

    function popBack() {
        if (tail == null) {
            throw new Toybox.Lang.ValueOutOfBoundsException("Empty list");
        }

        var temp = tail;
        
        if (tail.prev != null) {
            tail.prev.next = null;
        }

        tail = temp.prev;
        temp.prev = null;

        size--;
        
        return temp.data;
    }

    function getSize() {
        return size;
    }
}