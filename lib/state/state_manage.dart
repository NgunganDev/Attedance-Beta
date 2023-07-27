import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateManage {
  StateProvider statepage = StateProvider<int>((ref) => 0);
  StateProvider statetheme = StateProvider<bool>((ref) => false);
}

StateProvider stateauth = StateProvider<int>((ref) => 0);
