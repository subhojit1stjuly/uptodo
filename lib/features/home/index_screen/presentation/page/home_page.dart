import 'package:flutter/material.dart';
import 'package:uptodo/core/constants/app_localizations.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/custom_bottom_nav.dart';

/// HomePage is the page where the user will land after login
class HomePage extends StatefulWidget {
  /// const constructor for HomePage
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Text('Home'),
    Text('Calendar'),
    Text('Focus'),
    Text('Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Assets.icons.dash.svg(
          height: 24,
          width: 24,
        ),
        centerTitle: true,
        title: Text(
          textAlign: TextAlign.center,
          AppLocalizations.of(context)!.index,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}
