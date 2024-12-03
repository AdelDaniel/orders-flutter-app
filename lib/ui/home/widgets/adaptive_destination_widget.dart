import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:orders_flutter_app/res/responsive_extension.dart';
import 'package:orders_flutter_app/ui/home/models/adaptive_destination_model.dart';

/// A widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
class AdaptiveScaffoldWidget extends StatefulWidget {
  final Widget? title;
  final List<Widget> actions;
  final Widget? body;
  final int currentIndex;
  final List<AdaptiveDestinationModel> destinations;
  final ValueChanged<int> onNavigationIndexChange;
  final FloatingActionButton? floatingActionButton;

  const AdaptiveScaffoldWidget({
    this.title,
    this.body,
    this.actions = const [],
    required this.currentIndex,
    required this.destinations,
    required this.onNavigationIndexChange,
    this.floatingActionButton,
    super.key,
  });

  @override
  State<AdaptiveScaffoldWidget> createState() => _AdaptiveScaffoldWidgetState();
}

class _AdaptiveScaffoldWidgetState extends State<AdaptiveScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    // Show a Drawer
    if (context.isLargeScreen) {
      return Row(
        children: [
          Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Center(
                    child: widget.title,
                  ),
                ),
                for (var d in widget.destinations)
                  ListTile(
                    leading: Icon(d.icon),
                    title: Text(d.title),
                    selected:
                        widget.destinations.indexOf(d) == widget.currentIndex,
                    onTap: () => _destinationTapped(d),
                  ),
              ],
            ),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                actions: widget.actions,
              ),
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
            ),
          ),
        ],
      );
    }

    /// Show a navigation rail
    if (context.isMediumScreen) {
      return Scaffold(
        appBar: AppBar(
          title: widget.title,
          actions: widget.actions,
        ),
        body: Row(
          children: [
            NavigationRail(
              leading: widget.floatingActionButton,
              destinations: [
                ...widget.destinations.map(
                  (d) => NavigationRailDestination(
                    icon: Icon(d.icon),
                    label: Text(d.title),
                  ),
                ),
              ],
              selectedIndex: widget.currentIndex,
              onDestinationSelected: widget.onNavigationIndexChange,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            Expanded(
              child: widget.body!,
            ),
          ],
        ),
      );
    }

    /// Show a bottom app bar
    return Scaffold(
      body: widget.body,
      appBar: AppBar(
        title: widget.title,
        actions: widget.actions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          ...widget.destinations.map(
            (d) => BottomNavigationBarItem(
              icon: Icon(d.icon),
              label: d.title,
            ),
          ),
        ],
        currentIndex: widget.currentIndex,
        onTap: widget.onNavigationIndexChange,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  void _destinationTapped(AdaptiveDestinationModel destination) {
    var idx = widget.destinations.indexOf(destination);
    log("message index: $idx");
    if (idx != widget.currentIndex) {
      widget.onNavigationIndexChange(idx);
    }
  }
}
