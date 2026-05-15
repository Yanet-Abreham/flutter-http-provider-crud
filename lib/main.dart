import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_http/providers/user_provider.dart';
import 'package:flutter_provider_http/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Vault',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainEntryGate(),
    );
  }
}

class MainEntryGate extends StatefulWidget {
  const MainEntryGate({super.key});

  @override
  State<MainEntryGate> createState() => _MainEntryGateState();
}

class _MainEntryGateState extends State<MainEntryGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}