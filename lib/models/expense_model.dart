import 'package:expenses_app/db/app_db.dart';


class DatewiseExpenseModel {
  String date;
  String totalAmt;
  List<ExpenseModel> allTransactions;

  DatewiseExpenseModel({
    required this.date,
    required this.totalAmt,
    required this.allTransactions,
  });
}

class MonthwiseExpenseModel {
  String month;
  String totalAmt;
  List<ExpenseModel> allTransactions;

  MonthwiseExpenseModel({
    required this.month,
    required this.totalAmt,
    required this.allTransactions,
  });
}

class YearwiseExpenseModel {
  String year;
  String totalAmt;
  List<ExpenseModel> allTransactions;

  YearwiseExpenseModel({
    required this.year,
    required this.totalAmt,
    required this.allTransactions,
  });
}

class ExpenseModel {
  int expId;
  int uId;
  String expTitle;
  String expDesc;
  String expTimeStamp;
  num expAmt;
  num expBal;
  int expType;
  int expCatType;
  ExpenseModel({
    required this.expId,
    required this.uId,
    required this.expTitle,
    required this.expDesc,
    required this.expTimeStamp,
    required this.expAmt,
    required this.expBal,
    required this.expType,
    required this.expCatType,
  });

  //fromMap..
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        expId: map[AppDataBase.COLUMN_EXPENSE_ID],
        uId: map[AppDataBase.COLUMN_USER_ID],
        expTitle: map[AppDataBase.COLUMN_EXPENSE_TITLE],
        expDesc: map[AppDataBase.COLUMN_EXPENSE_DESC],
        expTimeStamp: map[AppDataBase.COLUMN_EXPENSE_TIMESTAMP],
        expAmt: map[AppDataBase.COLUMN_EXPENSE_AMT],
        expBal: map[AppDataBase.COLUMN_EXPENSE_BALANCE],
        expType: map[AppDataBase.COLUMN_EXPENSE_TYPE],
        expCatType: map[AppDataBase.COLUMN_EXPENSE_CAT_TYPE]);
  }

  //to map..
  Map<String, dynamic> toMap() {
    return {
      //AppDataBase.COLUMN_EXPENSE_ID: expId,
      AppDataBase.COLUMN_USER_ID: uId,
      AppDataBase.COLUMN_EXPENSE_TITLE: expTitle,
      AppDataBase.COLUMN_EXPENSE_DESC: expDesc,
      AppDataBase.COLUMN_EXPENSE_TIMESTAMP: expTimeStamp,
      AppDataBase.COLUMN_EXPENSE_AMT: expAmt,
      AppDataBase.COLUMN_EXPENSE_BALANCE: expBal,
      AppDataBase.COLUMN_EXPENSE_TYPE: expType,
      AppDataBase.COLUMN_EXPENSE_CAT_TYPE: expCatType,
    };
  }
}
