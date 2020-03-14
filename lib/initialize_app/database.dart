
import 'package:flutter_blog/database/Database.dart';

class InitDatabase
{
  Future initDb()async{
    await DatabaseManagerForFavourites.databaseManager.initDB();
    await DatabaseManagerForSavedOffline.databaseManager.initDB();
  }
}