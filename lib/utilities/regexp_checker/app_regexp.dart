class RegExpsTester {
  static bool nameCheck(String data) {
    RegExp pattern = new RegExp(r'[A-Za-z]{3,}');
    return pattern.hasMatch(data);
  }

  static bool mobileCheck(String data) {
    RegExp pattern = new RegExp(r'^(?:[0])?[0-9]{10}');
    return pattern.hasMatch(data);
  }

  static bool emailAddCheck(String data) {
    RegExp pattern = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return pattern.hasMatch(data);
  }

  static bool passCheck(String data) {
    RegExp pattern = new RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return pattern.hasMatch(data);
  }

  static bool dobChecker(String val) {
    RegExp pattern = new RegExp(r'[0-9/-]{8,}');
    return pattern.hasMatch(val);
  }
  static bool addressChecker(String data) {
    RegExp pattern = new RegExp(r'[0-9a-zA-Z ,/-]{15,50}');
    return pattern.hasMatch(data);
  }
}
