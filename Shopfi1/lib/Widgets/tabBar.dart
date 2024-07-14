import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Widgets/customerDataCard.dart';
import 'package:shopfi/Widgets/customerPaidAmount%20copy.dart';
import 'package:shopfi/Widgets/overlayWidgetCustomerCard.dart';



class tabBar extends StatefulWidget {
  final void Function(String function, Customer customer) starredCustomerFunction;
  final Customer customer;
  final void Function(String functionName, Customer customer, CustomerData customerData)  customerCardDataFunctions;
  const tabBar({required this.starredCustomerFunction,required this.customerCardDataFunctions,required this.customer,super.key});

  @override
  State<tabBar> createState() => _tabBarState();
}
 
class _tabBarState extends State<tabBar> {
  Color starColor = Colors.grey;
  
  // starred customer
 
  void starredCustomer(String function){
    if (function=="removed"){
      setState(() {
         widget.customer.isStarred = false;
         widget.starredCustomerFunction(function, widget.customer);
      });
     
      } if (function=="added"){
        setState(() {
          widget.customer.isStarred = true;
          widget.starredCustomerFunction(function, widget.customer); 
       });

      }

  }
  //adding customerDataCard 
  void addCustomerDataCard(CustomerData customerCard){
    setState(() {
      widget.customer.customerData.add(customerCard);
    });
  }

  void customerCardDataFunctions (String functionName, CustomerData customerData){
    if (functionName == "deleteCustomerCard"){
      setState(() {
        widget.customerCardDataFunctions(functionName,widget.customer,customerData);
      });
    }

     if (functionName == "amountPaid"){
      setState(() {
        widget.customerCardDataFunctions(functionName,widget.customer,customerData);
      });
    }

     if (functionName == "amountNotPaid"){
      setState(() {
        widget.customerCardDataFunctions(functionName,widget.customer,customerData);
      });
    }
    if (functionName=="amountAdded"){
      setState(() {
        widget.customerCardDataFunctions(functionName, widget.customer, customerData);
      });
      
    }

     if (functionName == "deleteAmountPaid"){
      setState(() {
        widget.customerCardDataFunctions(functionName,widget.customer,customerData);
      });
    }

  }


 
  
  @override
  Widget build(BuildContext context) {
    starColor = widget.customer.isStarred ? Colors.amber : Colors.grey;
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${widget.customer.name}'s Log", style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 30
          ),),
          actions: [
            IconButton(onPressed: () {
     if (starColor == Colors.grey) {
    starredCustomer("added");
  } else if (starColor == Colors.amber) {
    starredCustomer("removed");
  }
}, icon: Icon(Icons.star, color: starColor,)),
            IconButton(onPressed: (){
             showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => (OverlayWidgetCustomerCard(addCustomerDataCard: customerCardDataFunctions,)), useSafeArea: true);
            }, icon: Icon(Icons.add, size: 35, color: Theme.of(context).colorScheme.primary,),),
             const SizedBox(width: 20),
          ],
         
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
              tabs: const[
              Tab(
                icon: Icon(Icons.query_builder),
              ),
              Tab(
                icon: Icon(Icons.done),
              )
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        for (final data in widget.customer.customerData)
                        customerDataCard(customerCardDataFunctions: customerCardDataFunctions,customer: widget.customer,customerData: data,)
                      ],
                    ),
                  ),
                ),
                  Container(
                  child: Center(
                   child: Column(
                    children: [
                        const SizedBox(height: 10,),
                        for (final data in widget.customer.completedCustomerData)
                        customerPaidAmount(customerCardDataFunctions: customerCardDataFunctions,customer: widget.customer,customerData: data,)
                    ],
                   ),
                  ),
                )
              ]),
            )
          ],
        )
      ),
    );
  }
}