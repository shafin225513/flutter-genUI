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
      appBar: AppBar(title: Text("AI UI Generator"),
      backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
             controller: controller,
             decoration: InputDecoration(
             hintText: "e.g. create login form",
             prefixIcon: const Icon(Icons.bolt, color: Colors.blueAccent),
             suffixIcon: IconButton(
             icon: const Icon(Icons.clear, size: 20),
             onPressed: () => controller.clear(),
            ),
             border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30), 
               ),
             ),
           ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: generateUI,
              
              style: ElevatedButton.styleFrom(
              
              backgroundColor: Colors.blueAccent, 
              foregroundColor: Colors.white,      
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), 
               ),
             elevation: 2, 
             ),
             child: const Text(
              "Generate",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
           ),
         ),

            const SizedBox(height: 10,),
            Container(
             height: 1.0,           
             width: double.infinity, 
             color: Colors.black,     
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