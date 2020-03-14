import 'package:flutter_blog/Models/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {

  setData(String name, String photo, String email, bool signin)
  async {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setString('name', name);
    data.setString('email', email);
    data.setString('photo', photo);
    data.setBool('signin', signin);
  }

  Future<UserDataModel> getData() async {
    SharedPreferences data = await SharedPreferences.getInstance();

    return UserDataModel(data.getString('name'), data.getString('email'),
        data.getString('photo'), data.getBool('signin'));
  }

  removeSignIn() async
  {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.remove('signin');
  }
}
