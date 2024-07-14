import "package:intl/intl.dart";

class Customer {
  //instance variables 
  final String name;
  final int number;
  final String address;
  bool isStarred;
  final int customerID;
  final List<CustomerData> customerData;
  final List<CustomerData> completedCustomerData;
  static int _nextCustomerID = 0;

// constructor
  Customer(
      {required this.name,
      required this.number,
      required this.address,
      required this.customerData})
      : completedCustomerData = [], //  make this required so you can fill this out afterwards 
        isStarred = false,
        customerID = ++_nextCustomerID;


  // methods       
  double totalAmount() {
    double totalAmount = 0.0;
    for (final data in customerData) {
      totalAmount += data.amount;
    }
    return totalAmount;
  }

}




// inner class
class CustomerData {
  // instance variables 
  static int id = 0;
  final DateTime date;
  final double amount;
  final String title;
  final String note;

// constructor
  CustomerData(
      {required this.date,
      required this.amount,
      required this.title,
      required this.note}) {
    id += 1;
  }

//methods 
  String dateChange() {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
