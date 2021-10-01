class RegexConstans {
  static RegexConstans? _instace;
  static RegexConstans get instance {
    if (_instace != null) {
      return _instace!;
    }

    _instace = RegexConstans._init();
    return _instace!;
  }

  RegexConstans._init();

  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
}
