import "package:intl/intl.dart";
class Customer{
  final String name;
  final int number;
  final String address;
   bool isStarred;
  final List<CustomerData> customerData;
  final List<CustomerData> completedCustomerData;

  Customer({required this.name, required this.number, required this.address, required this.customerData }):completedCustomerData = [], isStarred= false;
double totalAmount(){
   double totalAmount = 0.0;
    for (final data in customerData) {
      totalAmount+= data.amount; }
    return totalAmount;
}
 
  
  // total Amount functionality 
 


}


class CustomerData {
  static int id=0;
  final DateTime date;
  final double amount;
  final String title;
  final String note;

  CustomerData ({required this.date, required this.amount, required this.title, required this.note}){
    id +=1;
  }
   
   String dateChange(){
     return DateFormat('dd/MM/yyyy').format(date);
  }

}