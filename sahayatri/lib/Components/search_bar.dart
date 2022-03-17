import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

Widget buildFloatingSearchBar(BuildContext context) {
  return FloatingSearchBar(
    hint: 'Place...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    borderRadius: const BorderRadius.all(Radius.circular(25)),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: true,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // children: Colors.accents.map((color) {
            //   return Container(height: 112, color: color);
            // }).toList(),
          ),
        ),
      );
    },
  );
}
