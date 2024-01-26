import 'package:expenses_app/Screens/Custom_widgets/custom_buttom.dart';
import 'package:expenses_app/Screens/Custom_widgets/custom_textfield.dart';
import 'package:expenses_app/app_constants/content_constants.dart';
import 'package:expenses_app/exp_bloc/exp_bloc.dart';
import 'package:expenses_app/exp_bloc/exp_event.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  num mBalance;
  AddExpenses({required this.mBalance});
  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  //for input data..
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amtController = TextEditingController();

  //dropdown items..
  var transactionType = ["Debit", "Credit"];

  var selectedTransactionType = "Debit";

  var selectedCatIndex = -1;

  DateTime expenseDate = DateTime.now(); //for default date..

  //method to select date..
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        expenseDate = picked;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Add Expense',
          
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(35),
                child: Column(children: [
                  CustomTextField(
                    mController: titleController,
                    hintText: 'Name your Expenses',
                    suffixIcon: Icon(
                      Icons.abc,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    mController: descController,
                    hintText: 'Add Desc',
                    suffixIcon: Icon(
                      Icons.abc,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    mController: amtController,
                    hintText: 'Enter Amount',
                    suffixIcon: Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                  ),
                ]),
              ),
              Container(
                width: 80,
                height: 30,
                child: DropdownButton(
                    value: selectedTransactionType,
                    items: transactionType
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      selectedTransactionType = value!;
                      setState(() {});
                    }),
              ),
              const SizedBox(height: 31),
              CustomButton(
                buttonColor: Colors.black,
                buttonTitle: 'Choose Expense',
                mWidget: selectedCatIndex != -1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConstants.mCategories[selectedCatIndex].catImgPath,
                            width: 30,
                            height: 30,
                          ),
                          Text(
                              "  -  ${AppConstants.mCategories[selectedCatIndex].catTitle}"),
                        ],
                      )
                    : null,
                titleColor: Colors.white,
                buttonOnTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(21)),
                      ),
                      context: context,
                      builder: (ctx) {
                        return GridView.builder(
                            padding: EdgeInsets.all(21),
                            itemCount: AppConstants.mCategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 11,
                                    crossAxisSpacing: 11),
                            itemBuilder: (ctx, index) {
                              var eachCat = AppConstants.mCategories[index];
                              return InkWell(
                                onTap: () {
                                  selectedCatIndex = index;
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: Colors.lightBlue.shade100),
                                  child: Image.asset(
                                    eachCat.catImgPath,
                                  ),
                                ),
                              );
                            });
                      });
                },
              ),
              const SizedBox(height: 11),
              CustomButton(
                buttonColor: Colors.white,
                buttonTitle:
                    DateFormat.yMMMMd().format(expenseDate),
                titleColor: Colors.black,
                buttonOnTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 11),
              CustomButton(
                buttonColor: Colors.black,
                buttonTitle: 'Add Expense',
                titleColor: Colors.white,
                buttonOnTap: () {
                  var myBalance=widget.mBalance;

                  if(transactionType == "Debit"){
                    myBalance -= int.parse(amtController.text.toString());
                  }else{
                    myBalance += int.parse(amtController.text.toString());
                  }
                  var nExpense = ExpenseModel(
                    expId: 0,
                    uId: 0,
                    expTitle: titleController.text.toString(),
                    expDesc: descController.text.toString(),
                    expTimeStamp: expenseDate.millisecondsSinceEpoch.toString(),
                    expAmt: int.parse(amtController.text.toString()),
                    expBal: myBalance,
                    expType: selectedTransactionType == "Debit" ?0:1,
                    expCatType: selectedCatIndex,
                  );
                  BlocProvider.of<ExpenseBloc>(context).add(AddExpenseEvent(newExpense: nExpense));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
