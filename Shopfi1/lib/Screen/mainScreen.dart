import 'package:flutter/material.dart';
import 'package:shopfi/Data/data.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Screen/filtersScreen.dart';
import 'package:shopfi/Widgets/customerCard.dart';
import 'package:shopfi/Widgets/mainDrawer.dart';
import 'package:shopfi/Widgets/mainScreenContainer.dart';
import 'package:shopfi/Widgets/overlayWidgetCustomer.dart';

const kFilter = {
  Filter.isPositive: false,
  Filter.isNegative:false
};

class mainScreen extends StatefulWidget {

  final List<Customer> availableCustomer;
  final bool isStarredScreen;
  final void Function(String function, Customer customer) starredCustomerFunction;
  final void Function(Customer customer) customerRemove;
  final void Function(String functionName, Customer customer, CustomerData customerData)  customerCardDataFunctions;
  

  const mainScreen({required this.isStarredScreen,required this.availableCustomer,required this.starredCustomerFunction,required this.customerRemove,required this.customerCardDataFunctions,super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  Map<Filter, bool> filterValues= kFilter; 

  //customerAdd fucntion 
  void addCustomer(Customer customer){
   setState(() {
    dataCollected.add(customer);
   });
  }
  
 
  
  // drawer functionality 
  void _switchDrawerScreen(String screen)async{
    Navigator.of(context).pop();
    if(screen == "filters"){
     final result =  await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx)=> filterScreen(filterValues)));
     setState(() {
       filterValues = result ?? kFilter;
     });
    } 
}
  // drawer functionality ends 
 
//container 1 values functionality



// container 1 values functionality overs 
  @override
  Widget build(BuildContext context) {

    var showData = widget.availableCustomer.where((customer) {
      if(filterValues[Filter.isNegative]! && customer.totalAmount()>0.0){
        return false ;
        } 
      if (filterValues[Filter.isPositive]! && customer.totalAmount()<0.0){
        return false;
      } else{
        return true;
      }

    }).toList();
    double amountBorrowed = 0.0;
 double amountGiven = 0.0;
 for (final customer in dataCollected){
  if(customer.totalAmount()>=0){
    amountGiven+=customer.totalAmount();
  } else{
    amountBorrowed+=customer.totalAmount();
  }
 }
     // container 1
       
    // container 1 ends 



    return Scaffold(
     appBar: AppBar(title:  Text("ShopFi", style: Theme.of(context).textTheme.displayLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary
      ),), centerTitle: true,
      actions: [
       IconButton(onPressed: (){
             showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => overlayWidgetCustomer(addCustomer: addCustomer,), useSafeArea: true);
            }, icon: Icon(Icons.add, size: 35, color: Theme.of(context).colorScheme.primary,),),
             const SizedBox(width: 20),
      ]),
      drawer: mainDrawer(switchDrawerScreen: _switchDrawerScreen,),
      body: SingleChildScrollView(
        child:  Column(
                children:  [
                  const SizedBox(height: 20,),
                
                  widget.isStarredScreen? Container():mainScreenContainer(amountBorrowed: amountBorrowed, amountGiven: amountGiven) ,
                  const SizedBox(height: 20,),
                   Text(widget.isStarredScreen ? " Starred Customers" : "Customers", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground
                        ),),
                  const SizedBox(height: 10,),
                 for (final customer in showData)
                 customerCard(starredCustomerFunction: widget.starredCustomerFunction,customerRemove: widget.customerRemove,customerCardDataFunctions: widget.customerCardDataFunctions, customer: customer)
                
                ]
      )
            
    )
    );
  }
}