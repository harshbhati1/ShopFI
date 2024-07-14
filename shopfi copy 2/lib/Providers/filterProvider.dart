import "package:riverpod/riverpod.dart";

enum Filter { isPositive, isNegative }


// this class will help us in managing the fliters
class filterClassNotifier extends StateNotifier<Map<Filter, bool>> {

  // constrcutor 
  filterClassNotifier()
      : super({
          Filter.isNegative: false,
          Filter.isPositive: false,
        });
        
  // methods 
  void addFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void updateFilter(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }
}

final filterProvider =
    StateNotifierProvider<filterClassNotifier, Map<Filter, bool>>(
        (ref) => filterClassNotifier());
