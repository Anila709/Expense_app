import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  AppDataBase._();

  static final AppDataBase instance=AppDataBase._();

  Database? myDB;

  //Login prefs key..
  static final String LOGIN_UID="uid";
 //tables
 static final String EXPENSE_TABLE= "expense";
 static final String USER_TABLE = "users";

 //users columns
 static final String COLUMN_USER_ID="uId";
 static final String COLUMN_USER_NAME="uName";
 static final String COLUMN_USER_EMAIL="uEmail";
 static final String COLUMN_USER_PASS="uPass";

 //expense column..
 static final String COLUMN_EXPENSE_ID="expId";
 static final String COLUMN_EXPENSE_TITLE="expTitle";
 static final String COLUMN_EXPENSE_DESC="expDesc";
 static final String COLUMN_EXPENSE_TIMESTAMP="expTimeStamp";
 static final String COLUMN_EXPENSE_AMT="expAmt";
 static final String COLUMN_EXPENSE_BALANCE="expBal";
 static final String COLUMN_EXPENSE_TYPE="expType"; //0 for debit ,1 for credit.
 static final String COLUMN_EXPENSE_CAT_TYPE="expCatType";



//to create or initialise db..
  Future<Database> initDB()async{
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath= join(docDirectory.path, "expenso.db");
    return await openDatabase(dbPath, version: 1,
    onCreate: (db, version) {
      // create tables here..
      //user table..
      db.execute("create table $USER_TABLE ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_PASS text)");
      db.execute("create table $EXPENSE_TABLE ( $COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_DESC text, $COLUMN_EXPENSE_TIMESTAMP text, $COLUMN_EXPENSE_AMT real, $COLUMN_EXPENSE_BALANCE real, $COLUMN_EXPENSE_TYPE integer, $COLUMN_EXPENSE_CAT_TYPE integer)");
    },);
  }

  //to fetch db..
  Future<Database> getDB()async{
    if(myDB !=null){
      return myDB!;
    }
    else{
      myDB = await initDB();
      return myDB!;
    }
  }

  //get uid..
  Future<int> getUID()async{
    var prefs = await SharedPreferences.getInstance();
    var uid=prefs.getInt(AppDataBase.LOGIN_UID);
    return uid ?? 0;
  }

  //quaries for user..
  Future<bool> createAccount(UserModel newUser)async{
    var check = await checkIfUserAlreadyExists(newUser.userEmail);
    if(!check){
      //create user..
      var db = await getDB();
      db.insert(USER_TABLE, newUser.toMap());
      return true;

    }
    else{
      //do not create table..
      return false;
    }
  }

  Future<bool> checkIfUserAlreadyExists(String email)async{
    var db= await getDB();
    var data=await db.query(USER_TABLE, where: "$COLUMN_USER_EMAIL=?",whereArgs: [email]);
    return data.isNotEmpty;
  }

  //login..
  Future<bool> authenticateUser(String email, String pass)async{
    var db = await getDB();
    var data=await db.query(USER_TABLE, where: "$COLUMN_USER_EMAIL=? and $COLUMN_USER_PASS=?",whereArgs: [email,pass]);

    if(data.isNotEmpty){
      var prefs =await SharedPreferences.getInstance();
      prefs.setInt(LOGIN_UID, UserModel.fromMap(data[0]).userId);
    }
    return data.isNotEmpty;

  }

  //expense crud operations..
  Future<bool> addExpense(ExpenseModel newExpense)async{
    var db=await getDB();
    int rowsEffected=await db.insert(EXPENSE_TABLE, newExpense.toMap());
    return rowsEffected>0;

  }

  Future<List<ExpenseModel>> fetchAllExpense()async{
     var db=await getDB();
     var data = await db.query(EXPENSE_TABLE, orderBy: "$COLUMN_EXPENSE_TIMESTAMP DESC");
     
     List<ExpenseModel> listData=[];

     for(Map<String, dynamic> eachExpense in data){
      listData.add(ExpenseModel.fromMap(eachExpense));
    
     }
     return listData;
  }
}