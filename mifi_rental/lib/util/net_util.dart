import 'dart:math';

class NetUtil {
  static String getSteamNo() {
    StringBuffer r = StringBuffer('APP');
    var date = DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .toString()
        .substring(0, 19)
        .replaceAll(' ', '')
        .replaceAll(':', '')
        .replaceAll('-', '');
    r.write(date);
    for (int i = 0; i < 6; i++) {
      r.write(Random().nextInt(9));
    }
    return r.toString();
  }
}
