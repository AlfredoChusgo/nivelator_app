class FixedQueue<T> {
  final int limit;
  final List<T> _queue = [];

  FixedQueue(this.limit);

  void push(T element) {
    if (_queue.length >= limit) {
      _queue.removeAt(0); // Remove the oldest element
    }
    _queue.add(element); // Add the new element
  }

  List<T> toList() {
    return List.unmodifiable(_queue); // Return an unmodifiable copy of the queue
  }

  @override
  String toString() {
    return _queue.toString();
  }
}
