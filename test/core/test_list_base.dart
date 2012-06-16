class TestListBase extends ListBase<int> {
  static final int _length = 5;

  final bool flip;

  TestListBase([this.flip = false]);

  /**
   * Returns the number of elements in this collection.
   */
  int get length() => flip ? _length * 2 : _length;

  /**
   * Returns the element at the given [index] in the list or throws
   * an [IndexOutOfRangeException] if [index] is out of bounds.
   */
  int operator [](int index) {
    assert(index >= 0 && index < length);

    if (index < _length) {
      return _length - index;
    }
    index -= _length;
    return index + 1;
  }

  static void run() {
    group('ListBase', (){
      test('simple', _testSimple);
      test('map', _testMap);
      test('indexOf', _testIndexOf);
    });
  }

  static void _testSimple() {
    var test = new TestListBase();

    var list = new List<int>.from(test);
    expect(list.length, equals(_length));
    expect(list, orderedEquals([5,4,3,2,1]));
  }

  static void _testMap() {
    Func1<int, int> dub = (i) => i * 2;

    var test = new TestListBase();

    List<int> list = new List<int>.from(test.map(dub));
    expect(list.length, equals(_length));
    expect(list, orderedEquals([10, 8, 6, 4, 2]));
  }

  static void _testIndexOf() {
    var test = new TestListBase(true);

    //
    // All positive, start at 0
    //
    for (var i = 1; i <= _length; i++) {
      expect(test.indexOf(i), equals(_length - i));
      expect(test.lastIndexOf(i), equals(_length + i - 1));
    }

    //
    // Start at index `_length`
    //
    for (var i = 1; i <= _length; i++) {
      expect(test.indexOf(i, _length), equals(_length + i - 1));
      expect(test.lastIndexOf(i, _length), equals(_length + i - 1));
    }

    //
    // look for '1' after the last '1'
    //
    expect(test.indexOf(1, _length + 1), equals(-1));
    expect(test.lastIndexOf(1, _length + 1), equals(-1));

    //
    // look for '0' which isn't there
    //
    expect(test.indexOf(0), equals(-1));
    expect(test.lastIndexOf(0), equals(-1));
  }
}
