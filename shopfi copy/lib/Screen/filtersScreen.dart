import 'package:flutter/material.dart';
import 'package:shopfi/Providers/filterProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actualFilter = ref.watch(filterProvider); // using filters provider
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
      body: Column(
        children: [
          SwitchListTile(
            value: actualFilter[Filter.isPositive]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .addFilter(Filter.isPositive, isChecked);
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
            value: actualFilter[Filter.isNegative]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .addFilter(Filter.isNegative, isChecked);
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
    );
  }
}
