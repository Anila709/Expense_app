import 'package:expenses_app/db/app_db.dart';

class UserModel{
  int userId;
  String userName;
  String userEmail;
  String userPass;
  UserModel({required this.userId,required this.userName, required this.userEmail, required this.userPass,});


  //fromMap -> Model..
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      userId: map[AppDataBase.COLUMN_USER_ID], 
      userName: map[AppDataBase.COLUMN_USER_NAME], 
      userEmail: map[AppDataBase.COLUMN_USER_EMAIL], 
      userPass: map[AppDataBase.COLUMN_USER_PASS],
      );
  }

  //model -> toMap..
  Map<String, dynamic> toMap(){
    return {
      // AppDataBase.COLUMN_USER_ID : userId, because it is autoincrement..
      AppDataBase.COLUMN_USER_NAME : userName,
      AppDataBase.COLUMN_USER_EMAIL : userEmail,
      AppDataBase.COLUMN_USER_PASS : userPass,

    };
  }

}