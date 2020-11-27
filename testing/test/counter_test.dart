import 'package:test/test.dart';

import 'package:testing/counter.dart';

void main() {
  initialization();
  actions();
}

void initialization() {
  group("Counter si inizializza correttamente", () {
    test("Counter ha valore iniziale uguale a zero", () {
      final counter = Counter();
      expect(counter.value, 0);
    });
  });
}

void actions() {
  group("Counter esegue azioni correttamente", () {
    test("Counter dovrebbe incrementarsi correttamente", () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test("Counter dovrebbe decremenetarsi correttamente", () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
