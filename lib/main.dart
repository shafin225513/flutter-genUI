import 'package:flutter/material.dart';
import 'services/ai_service.dart';
import 'widgets/dynamic_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final AIService aiService = AIService();

  Map<String, dynamic>? uiConfig;
  bool isLoading = false;

  void generateUI() async {
    setState(() => isLoading = true);

    try {
      final result = await aiService.generateUI(controller.text);
      setState(() => uiConfig = result);
    } catch (e) {
      print(e);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI UI Generator")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "e.g. create login form",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: generateUI,
              child: Text("Generate"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : uiConfig != null
                    ? buildWidget(uiConfig!)
                    : Container(),
                    
          ],
        ),
      ),
    );
  }
}