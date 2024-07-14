import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/Data/data.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:flutter/material.dart';
import 'package:shopfi/Providers/filterProvider.dart';


// this class will help us in storing and editing the data 
class dataNotifier extends StateNotifier<List<Customer>> {
  // constructor 
  dataNotifier() : super(dataCollected);

 // methods 

 // customer methods 
  void addCustomer(BuildContext context, Customer customer) {
    List<Customer> newList = List<Customer>.from(state);
    newList.add(customer);
    scaffoldMessenger(context, "Customer is added");
    state = newList;
  }

  void removeCustomer(BuildContext context, Customer customer) {
    List<Customer> newList = List<Customer>.from(state);
    newList.remove(customer);
    scaffoldMessenger(context, "Customer is removed");
    state = newList;
  }
// customer card methods 
  void addCustomerData(
      BuildContext context, Customer customer, CustomerData customerData) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].customerData.add(customerData);
    scaffoldMessenger(context, "New note is added");
    state = newList;
  }

  void removeCustomerData(
      BuildContext context, Customer customer, CustomerData customerData) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].customerData.remove(customerData);
    scaffoldMessenger(context, "Note is removed");
    state = newList;
  }

  void addCustomerToPaidCustomerData(
      BuildContext context, Customer customer, CustomerData customerData) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].completedCustomerData.add(customerData);
    newList[indexOfCustomer].customerData.remove(customerData);
    state = newList;
    scaffoldMessenger(context, "Note is added to paid list");
  }

  void moveBackToCustomerData(
      BuildContext context, Customer customer, CustomerData customerData) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].customerData.add(customerData);
    newList[indexOfCustomer].completedCustomerData.remove(customerData);
    scaffoldMessenger(context, "Note is add to unpaid list");
    state = newList;
  }

  void deletePaidAmount(
      BuildContext context, Customer customer, CustomerData customerData) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].completedCustomerData.remove(customerData);
    state = newList;
    scaffoldMessenger(context, "Note is removed");
  }

// helper methods 
  void isStarred(BuildContext context, Customer customer, bool value) {
    List<Customer> newList = List<Customer>.from(state);
    int indexOfCustomer = newList.indexOf(customer);
    newList[indexOfCustomer].isStarred = value;
    scaffoldMessenger(
        context,
        value == true
            ? "Customer is added to the starred list"
            : "Customer is removed from the starred list");
    state = newList;
  }

  void scaffoldMessenger(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


// this provider is used for handling the starred items (will help to change the starred customer list)
class starredNotifier extends StateNotifier<List<Customer>> {
  starredNotifier() : super([]);

  void addCustomerToStarred(BuildContext context, Customer customer) {
    List<Customer> newList = List.from(state);
    dataNotifier().isStarred(context, customer, true);
    newList.add(customer);
    state = newList;
  }

  void removeCustomerToStarred(BuildContext context, Customer customer) {
    List<Customer> newList = List.from(state);
    dataNotifier().isStarred(context, customer, false);
    newList.remove(customer);
    state = newList;
  }
}


final dataNotifierProvider =
    StateNotifierProvider<dataNotifier, List<Customer>>(
        (ref) => dataNotifier());

final starredNotifierProvider =
    StateNotifierProvider<starredNotifier, List<Customer>>(
        (ref) => starredNotifier());




// this provider will helpm us to provide the customer list after applying the filters 
final screenNotifierProvider = Provider((ref) {
  final dataNotifierset = ref.watch(dataNotifierProvider);
  final filterNotifier = ref.watch(filterProvider);
  return dataNotifierset.where((customer) {
    if (filterNotifier[Filter.isNegative]! && customer.totalAmount() > 0.0) {
      return false;
    }
    if (filterNotifier[Filter.isPositive]! && customer.totalAmount() < 0.0) {
      return false;
    } else {
      return true;
    }
  }).toList();
});




