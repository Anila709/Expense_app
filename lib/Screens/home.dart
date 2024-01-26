import 'package:expenses_app/Screens/add_expense.dart';
import 'package:expenses_app/app_constants/content_constants.dart';
import 'package:expenses_app/date_time_utils.dart';
import 'package:expenses_app/exp_bloc/exp_bloc.dart';
import 'package:expenses_app/exp_bloc/exp_event.dart';
import 'package:expenses_app/exp_bloc/exp_state.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //var dateFormat = DateFormat.yMd();

  num balance = 0.0;

  //dropdown menu for filter expenses..
  var filterExpenses = ["Date", "Month", "Year"];
  var selectedFilterExpenseType="Date";
   bool isDatewise=false;
   bool isMonthwise=false;
   bool isYearwise=false;

  @override
  void initState() {
    super.initState();
     isDatewise=selectedFilterExpenseType=="Date";
    BlocProvider.of<ExpenseBloc>(context).add(FetchExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    //using mediaQuery to get screen height and width..
    var mq = MediaQuery.of(context);
    // var mWidth = mq.size.width;
    // var mHeith = mq.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Expenses',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.teal,
        actions: [
          DropdownButton(
            style: TextStyle(color: Colors.white),
            dropdownColor: Colors.grey.shade700,
            isDense: true,
            focusColor: Colors.white,
            value: selectedFilterExpenseType,
            items: filterExpenses
                .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type)))
                .toList(),
            onChanged: (value) {
              selectedFilterExpenseType=value!;
              setState(() {
                 isDatewise=selectedFilterExpenseType=="Date";
                 isMonthwise=selectedFilterExpenseType=="Month";
                 isYearwise=selectedFilterExpenseType=="Year";
              });
            },
          ),
          Switch(
              value: context.watch<ThemeProvider>().themeValue,
              onChanged: (value) {
                context.read<ThemeProvider>().themeValue = value;
              })
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExpenseErrorState) {
            return Text(state.errorMsg);
          }
          if (state is ExpenseLoadedState) {
            if (state.mData.isNotEmpty) {
              updateBalance(state.mData);
             
              
              
              
              // return mWidth>mHeith ?landscapeLayout(datewiseExpense):portraitLayout(datewiseExpense);
              //or we can do other ways.
              if(isDatewise){
                var datewiseExpense = filterDayWiseExpenses(state.mData);
                 return mq.orientation == Orientation.landscape
                  ? datewiseLandscapeLayout(datewiseExpense)
                  : datewisePortraitLayout(datewiseExpense);
              }
              if(isMonthwise==true){
                var monthwiseExpense=filterMonthWiseExpenses(state.mData);
                 return mq.orientation == Orientation.landscape
                  ? monthwiseLandscapeLayout(monthwiseExpense)
                  : monthwisePortraitLayout(monthwiseExpense);
              }
              if(isYearwise==true){
                var yearwiseExpense=filterYearWiseExpenses(state.mData);
                 return mq.orientation == Orientation.landscape
                  ? yearwiseLandscapeLayout(yearwiseExpense)
                  : yearwisePortraitLayout(yearwiseExpense);
              }
              
            } else {
              return Center(
                child: Text('No Expenses Yet!!!'),
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpenses(mBalance: balance)));
        },
      ),
    );
  }

//current balance will be update here...
  void updateBalance(List<ExpenseModel> mData) {
    var lastTransactionId = -1;
    for (ExpenseModel exp in mData) {
      if (exp.expId > lastTransactionId) {
        lastTransactionId = exp.expId;
      }
    }
    var lastExpBal = mData
        .firstWhere((element) => element.expId == lastTransactionId)
        .expBal;
    balance = lastExpBal;
  }
//balance header..
Widget balanceHeader() {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your balance till now:'),
          Text(
            '$balance',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }

  //datewise.. layouts..
  Widget datewisePortraitLayout(List<DatewiseExpenseModel> datewiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 2,
            child: datewiseMainLayout(datewiseExpense),
          ),
        ],
      ),
    );
  }

  Widget datewiseLandscapeLayout(List<DatewiseExpenseModel> datewiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 1,
            child: datewiseMainLayout(datewiseExpense),
          ),
        ],
      ),
    );
  }

  
  Widget datewiseMainLayout(List<DatewiseExpenseModel> datewiseExpense) {
    return ListView.builder(
        itemCount: datewiseExpense.length,
        itemBuilder: (context, index) {
          var eachItem = datewiseExpense[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${eachItem.date}"),
                  Text("${eachItem.totalAmt}"),
                ],
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: eachItem.allTransactions.length,
                  itemBuilder: (_, childIndex) {
                    var eachTrans = eachItem.allTransactions[childIndex];
                    return ListTile(
                      leading: Image.asset(AppConstants
                          .mCategories[eachTrans.expCatType].catImgPath),
                      title: Text(eachTrans.expTitle),
                      subtitle: Text(eachTrans.expDesc),
                      trailing: Column(
                        children: [
                          Text(eachTrans.expAmt.toString(),style: TextStyle(color: eachTrans.expType==0?Colors.red:Colors.green),),

                          ///balance will be added here
                          Text(eachTrans.expBal.toString()),
                        ],
                      ),
                    );
                  })
            ],
          );
        });
  }


//monthwise..layouts..
 Widget monthwisePortraitLayout(List<MonthwiseExpenseModel> monthwiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 2,
            child: monthwiseMainLayout(monthwiseExpense),
          ),
        ],
      ),
    );
  }

  Widget monthwiseLandscapeLayout(List<MonthwiseExpenseModel> monthwiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 1,
            child: monthwiseMainLayout(monthwiseExpense),
          ),
        ],
      ),
    );
  }

   Widget monthwiseMainLayout(List<MonthwiseExpenseModel> monthwiseExpense) {
    return ListView.builder(
        itemCount: monthwiseExpense.length,
        itemBuilder: (context, index) {
          var eachItem = monthwiseExpense[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(eachItem.month),
                  Text(eachItem.totalAmt),
                ],
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: eachItem.allTransactions.length,
                  itemBuilder: (_, childIndex) {
                    var eachTrans = eachItem.allTransactions[childIndex];
                    return ListTile(
                      leading: Image.asset(AppConstants
                          .mCategories[eachTrans.expCatType].catImgPath),
                      title: Text(eachTrans.expTitle),
                      subtitle: Text(eachTrans.expDesc),
                      trailing: Column(
                        children: [
                          Text(eachTrans.expAmt.toString(),style: TextStyle(color: eachTrans.expType==0?Colors.red:Colors.green)),

                          ///balance will be added here
                          Text(eachTrans.expBal.toString()),
                        ],
                      ),
                    );
                  })
            ],
          );
        });
  }

//yearwise.. layouts..

 Widget yearwisePortraitLayout(List<YearwiseExpenseModel> yearwiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 2,
            child: yearwiseMainLayout(yearwiseExpense),
          ),
        ],
      ),
    );
  }

  Widget yearwiseLandscapeLayout(List<YearwiseExpenseModel> yearwiseExpense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: balanceHeader(),
          ),
          Expanded(
            flex: 1,
            child: yearwiseMainLayout(yearwiseExpense),
          ),
        ],
      ),
    );
  }

   Widget yearwiseMainLayout(List<YearwiseExpenseModel> yearwiseExpense) {
    return ListView.builder(
        itemCount: yearwiseExpense.length,
        itemBuilder: (context, index) {
          var eachItem = yearwiseExpense[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${eachItem.year}"),
                  Text("${eachItem.totalAmt}"),
                ],
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: eachItem.allTransactions.length,
                  itemBuilder: (_, childIndex) {
                    var eachTrans = eachItem.allTransactions[childIndex];
                    return ListTile(
                      leading: Image.asset(AppConstants
                          .mCategories[eachTrans.expCatType].catImgPath),
                      title: Text(eachTrans.expTitle),
                      subtitle: Text(eachTrans.expDesc),
                      trailing: Column(
                        children: [
                          Text(eachTrans.expAmt.toString(),style: TextStyle(color: eachTrans.expType==0?Colors.red:Colors.green)),

                          ///balance will be added here
                          Text(eachTrans.expBal.toString()),
                        ],
                      ),
                    );
                  })
            ],
          );
        });
  }



//datewise expenses...
  List<DatewiseExpenseModel> filterDayWiseExpenses(
      List<ExpenseModel> allExpenses) {
    //dateWiseExpenses.clear();
    List<DatewiseExpenseModel> dateWiseExpenses = [];

    var listUniqueDates = [];

    for (ExpenseModel eachExp in allExpenses) {
      var mDate = DateTimeUtils.getFormattedDateFromMilliseconds(
          int.parse(eachExp.expTimeStamp));

      if (!listUniqueDates.contains(mDate)) {
        ///not contains
        listUniqueDates.add(mDate);
      }
    }

    //print(listUniqueDates);

    for (String date in listUniqueDates) {
      List<ExpenseModel> eachDateExp = [];
      var totalAmt = 0.0;

      for (ExpenseModel eachExp in allExpenses) {
        var mDate = DateTimeUtils.getFormattedDateFromMilliseconds(
            int.parse(eachExp.expTimeStamp));

        if (date == mDate) {
          eachDateExp.add(eachExp);

          if (eachExp.expType == 0) {
            ///debit
            totalAmt -= eachExp.expAmt;
          } else {
            ///credit
            totalAmt += eachExp.expAmt;
          }
        }
      }

      //for today..

      var formattedTodayDate =
          DateTimeUtils.getFormattedDateFromDateTime(DateTime.now());
      if (formattedTodayDate == date) {
        date = "Today";
      }

      //for yesterday..

      var formattedYesterdayDate = DateTimeUtils.getFormattedDateFromDateTime(
          DateTime.now().subtract(const Duration(days: 1)));
      if (formattedYesterdayDate == date) {
        date = "Yesterday";
      }

      dateWiseExpenses.add(DatewiseExpenseModel(
          date: date,
          totalAmt: totalAmt.toString(),
          allTransactions: eachDateExp));
    }

    return dateWiseExpenses;
  }

  //month wise expenses..
  List<MonthwiseExpenseModel> filterMonthWiseExpenses(
      List<ExpenseModel> allExpenses) {
    //dateWiseExpenses.clear();
    List<MonthwiseExpenseModel> monthWiseExpenses = [];

    var listUniqueMonths = [];

    for (ExpenseModel eachExp in allExpenses) {
      var mMonth = DateTimeUtils.getFormattedMonthFromMilliseconds(
          int.parse(eachExp.expTimeStamp));

      if (!listUniqueMonths.contains(mMonth)) {
        ///not contains
        listUniqueMonths.add(mMonth);
      }
    }

    //print(listUniqueDates);

    for (String month in listUniqueMonths) {
      List<ExpenseModel> eachMonthExp = [];
      var thisMonthBalance = 0.0;

      for (ExpenseModel eachExp in allExpenses) {
        var mMonth = DateTimeUtils.getFormattedMonthFromMilliseconds(
            int.parse(eachExp.expTimeStamp));

        if (month == mMonth) {
          eachMonthExp.add(eachExp);

          if (eachExp.expType == 0) {
            ///debit
            thisMonthBalance -= eachExp.expAmt;
          } else {
            ///credit
            thisMonthBalance += eachExp.expAmt;
          }
        }
      }

      //for this month..

      var formattedThisMonth =
          DateTimeUtils.getFormattedMonthFromDateTime(DateTime.now());
      if (formattedThisMonth == month) {
        month = "This month";
      }

      // //for last month..

      // var formattedLastmonth = DateTimeUtils.getFormattedMonthFromDateTime(
      //     DateTime.now().subtract(const Duration(days: 28)));
      // if (formattedLastmonth == month) {
      //   month = "Last month";
      // }

      monthWiseExpenses.add(MonthwiseExpenseModel(
          month: month,
          totalAmt: thisMonthBalance.toString(),
          allTransactions: eachMonthExp));
    }

    return monthWiseExpenses;
  }

  //year wise expenses..
  List<YearwiseExpenseModel> filterYearWiseExpenses(
      List<ExpenseModel> allExpenses) {
    List<YearwiseExpenseModel> yearWiseExpenses = [];

    var listUniqueYears = [];

    for (ExpenseModel eachExp in allExpenses) {
      var mYear = DateTimeUtils.getFormattedYearFromMilliseconds(
          int.parse(eachExp.expTimeStamp));

      if (!listUniqueYears.contains(mYear)) {
        ///not contains
        listUniqueYears.add(mYear);
      }
    }

    //print(listUniqueDates);

    for (String year in listUniqueYears) {
      List<ExpenseModel> eachYearExp = [];
      var thisYearBalance = 0.0;

      for (ExpenseModel eachExp in allExpenses) {
        var mYear = DateTimeUtils.getFormattedYearFromMilliseconds(
            int.parse(eachExp.expTimeStamp));

        if (year == mYear) {
          eachYearExp.add(eachExp);

          if (eachExp.expType == 0) {
            ///debit
            thisYearBalance -= eachExp.expAmt;
          } else {
            ///credit
            thisYearBalance += eachExp.expAmt;
          }
        }
      }

      //for this month..

      var formattedThisYear =
          DateTimeUtils.getFormattedYearFromDateTime(DateTime.now());
      if (formattedThisYear == year) {
        year = "This year";
      }

      // //for last month..

      // var formattedLastmonth = DateTimeUtils.getFormattedMonthFromDateTime(
      //     DateTime.now().subtract(const Duration(days: 28)));
      // if (formattedLastmonth == month) {
      //   month = "Last month";
      // }

      yearWiseExpenses.add(YearwiseExpenseModel(
          year: year,
          totalAmt: thisYearBalance.toString(),
          allTransactions: eachYearExp));
    }

    return yearWiseExpenses;
  }
}
