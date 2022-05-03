class Utilities {
  // This is simply a "smart" implementation of a regular switch-case that is directly usable as is
  // in the Scaffold code area.
  static TValue? customCase<TOptionType, TValue>(
      TOptionType selectedOption, Map<TOptionType, TValue> branches) {
    return branches[selectedOption];
  }
}
