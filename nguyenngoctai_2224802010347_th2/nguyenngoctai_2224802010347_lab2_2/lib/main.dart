import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: ResponsiveHomePage());
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  static const colorCodes = (
    body: Color(0xFFF8E287),
    navigation: Color(0xFFC5ECCE),
    pane: Color(0xFFEFE2BC),
  );

  static const _style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const body = Center(child: Text('Body', style: _style));
  static const navigation = Center(child: Text('Navigation', style: _style));
  static const panes = Center(child: Text('Pane', style: _style));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenWidth < 600
              ? 'Responsive UI - Phone'
              : screenWidth < 840
              ? 'Responsive UI - Tablet'
              : screenWidth < 1200
              ? 'Responsive UI - Landscape'
              : 'Responsive UI - Large Desktop',
        ),
      ),
      body: screenWidth < 600
          ? buildCompactScreen()
          : screenWidth < 840
          ? buildMediumScreen()
          : screenWidth < 1200
          ? buildExpandedScreen()
          : buildLargeScreen(),
    );
  }

  Widget buildCompactScreen() => Column(
    children: [
      Expanded(
        child: Container(color: colorCodes.body, child: body),
      ),
      Container(height: 80, color: colorCodes.navigation, child: navigation),
    ],
  );

  Widget buildMediumScreen() => Row(
    children: [
      Container(width: 80, color: colorCodes.navigation),
      Expanded(
        child: Container(color: colorCodes.body, child: body),
      ),
    ],
  );

  Widget buildExpandedScreen() => Row(
    children: [
      Container(width: 80, color: colorCodes.navigation),
      Container(width: 360, color: colorCodes.body, child: body),
      Expanded(
        child: Container(color: colorCodes.pane, child: panes),
      ),
    ],
  );

  Widget buildLargeScreen() => Row(
    children: [
      Container(width: 360, color: colorCodes.navigation, child: navigation),
      Container(width: 360, color: colorCodes.body, child: body),
      Expanded(
        child: Container(color: colorCodes.pane, child: panes),
      ),
    ],
  );
}
