import 'package:flutter/material.dart';
import 'package:shopfi/Data/data.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Screen/mainScreen.dart';


class tabsScreen extends StatefulWidget {
  const tabsScreen({super.key});

  @override
  State<tabsScreen> createState() => _tabsScreenState();
}

class _tabsScreenState extends State<tabsScreen> {

  //functionality for starred screen 
  List<Customer> starredCustomerList = [];

  void clikedStarredCustomer(String function,Customer customer){
    if(starredCustomerList.contains(customer) && function == "removed"){
      setState(() {
        customer.isStarred = false;
        starredCustomerList.remove(customer);
         scaffoldMessenger(context,"Customer is removed from the starred list");
         
      });
    } if(function == "added"){
      setState(() {
        customer.isStarred = true;
        starredCustomerList.add(customer);
         scaffoldMessenger(context,"Customer is added to the starred list");
      });
    }
    
  }
  
  // functionality for changing tabs from bottomnaivigationbar
  int index = 0;
  void _changeIndex(int index){
    setState(() {
      this.index = index;
    });
  }
  // ends...........   bottomo Navigation Bar 

  // customerCardData Function
void customerCardDataFunctions(String functionName, Customer customer, CustomerData customerData){
  // customerCardData Function
  // delete card function 
   if (functionName == "deleteCustomerCard"){
    setState(() {
        customer.customerData.remove(customerData);
        scaffoldMessenger(context,"Note is removed");
      });
   }

   //amount added function 
   if (functionName=="amountAdded"){
    setState(() {
      customer.customerData.add(customerData);
      scaffoldMessenger(context,"New note is added");
    });
   }
  //amount paid function 
  if (functionName == "amountPaid"){
     setState(() {
        customer.customerData.remove(customerData);
        customer.completedCustomerData.add(customerData);
        scaffoldMessenger(context, "Note is added to paid list");
      });
  }

  // amount not Paid 
  if (functionName == "amountNotPaid"){
     setState(() {
        customer.customerData.add(customerData);
        customer.completedCustomerData.remove(customerData);
        scaffoldMessenger(context,"Note is add to unpaid list");
      });
  }

  // delete Amount Paid 
  if (functionName == "deleteAmountPaid"){
     setState(() {
        customer.completedCustomerData.remove(customerData);
        scaffoldMessenger(context,"Note is removed");
      });
  }


}

//customer Remove 
void customerRemove(Customer customer){
  setState(() {
    if (dataCollected.contains(customer)){
      setState(() {
        dataCollected.remove(customer);
        scaffoldMessenger(context, "Customer is removed");
      });
    }
  });
}
 

  // scaffoldMessanger 
  void scaffoldMessenger(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500

      )),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  @override
  Widget build(BuildContext context) {
  // Bottom Navigation Bar functionality 
    Widget screenInUse =  mainScreen(isStarredScreen: false,availableCustomer: dataCollected,starredCustomerFunction: clikedStarredCustomer,customerRemove: customerRemove,customerCardDataFunctions: customerCardDataFunctions);
    if (index==1){
      screenInUse =mainScreen(isStarredScreen: true,availableCustomer: starredCustomerList, starredCustomerFunction: clikedStarredCustomer, customerRemove: customerRemove, customerCardDataFunctions: customerCardDataFunctions);
    }
    // Bottom Navigattion Bar functionality overs 


    return Scaffold(
      body: screenInUse,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _changeIndex(index);
        }
        ,currentIndex: index
        ,items: const [BottomNavigationBarItem(icon: Icon(Icons.person), label: "mainScreen"), 
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "starredCustomer")]),
    );
  }
}