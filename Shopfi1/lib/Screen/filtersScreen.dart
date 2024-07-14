import 'package:flutter/material.dart';

class filterScreen extends StatefulWidget {
  final Map<Filter, bool> actualFilter;
  const filterScreen(this.actualFilter,{Key? key}) : super(key: key);

  @override
  State<filterScreen> createState() => _FilterScreenState();
}

enum Filter{
  isPositive, 
  isNegative
}

class _FilterScreenState extends State<filterScreen> {
  var _isPositive = false;
  var _isNegative = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isNegative = widget.actualFilter[Filter.isNegative]!;
    _isPositive = widget.actualFilter[Filter.isPositive]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filters",
          style: Theme.of(context).textTheme.headline4!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop){
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.isNegative: _isNegative,
            Filter.isPositive: _isPositive
          });
        } ,
        child: Column(
          children: [
            SwitchListTile(
              value: _isPositive,
              onChanged: (isChecked) {
                setState(() {
                  _isPositive = isChecked;
                });
              },
              title: Text(
                "Creditor",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                "Help you find people whom you owe money",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            SwitchListTile(
              value: _isNegative,
              onChanged: (isChecked) {
                setState(() {
                  _isNegative = isChecked;
                });
              },
              title: Text(
                "Borrower",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                "Help you find people who owe you money",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
          ],
        ),
      ),
    );
  }
}
