import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static String KEY_USERID = "user_id";
  static String KEY_ROLEID = "role_id";
  static String KEY_TOKEN = "token";
  static String KEY_TOKEN_KEY = "token_key";
  static String KEY_KAPALID = "kapal_id";

  static String KEY_NAMA = "nama";
  static String KEY_ALAMAT = "alamat";
  static String KEY_TELP = "noHP";

  static void setUserId(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_USERID, userId);
  }

  static Future<String> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_USERID)}';
  }

  static void setRoleId(String roleId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_ROLEID, roleId);
  }

  static Future<String> getRoleId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_ROLEID)}';
  }

  static void setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_TOKEN, token);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_TOKEN)}';
  }

  static void setTokenKey(String tokenKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_TOKEN_KEY, tokenKey);
  }

  static Future<String> getTokenKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_TOKEN_KEY)}';
  }

  static void setKapalId(String kapalId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_KAPALID, kapalId);
  }

  static Future<String> getKapalId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_KAPALID)}';
  }

  static void setNama(String nama) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_NAMA, nama);
  }

  static Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_NAMA)}';
  }

  static void setAlamat(String alamat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_ALAMAT, alamat);
  }

  static Future<String> getAlamat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_ALAMAT)}';
  }

  static void setTelp(String telp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(KEY_TELP, telp);
  }

  static Future<String> getTelp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return '${pref.getString(KEY_TELP)}';
  }

  void logout(){
    setUserId('');
    setToken('');
    setRoleId('');
    setTokenKey('');
    setNama('');
    setTelp('');
    setAlamat('');
    setKapalId('');
  }


}