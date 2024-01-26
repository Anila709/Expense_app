import 'package:expenses_app/db/app_db.dart';
import 'package:expenses_app/exp_bloc/exp_event.dart';
import 'package:expenses_app/exp_bloc/exp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent ,ExpenseState>{

  AppDataBase db;

  ExpenseBloc({required this.db}) : super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit) async{
     emit(ExpenseLoadingState());
     var check = await db.addExpense(event.newExpense);
     if(check){
      var mExp = await db.fetchAllExpense();
      emit(ExpenseLoadedState(mData: mExp));
     }
     else{
      emit(ExpenseErrorState(errorMsg: "Expense not Added"));
     }
    });

    on<FetchExpenseEvent>((event, emit)async {
       emit(ExpenseLoadingState());
       var mExp=await db.fetchAllExpense();
       emit(ExpenseLoadedState(mData: mExp));
    });

    on<UpdateExpenseEvent>((event, emit) {

    });

    on<DeleteExpenseEvent>((event, emit) {

    });
  }


  
}