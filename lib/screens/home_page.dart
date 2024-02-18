import 'package:flutter/material.dart';
import 'package:mobigic_technologies_test/screens/alphabets_searchs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController mController = TextEditingController(),
      nController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    mController.dispose();
    nController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: mController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the number M',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the number N',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150.0,
              height: 50.0,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    if (mController.text.isNotEmpty &&
                        nController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlphabetsSearchsPage(
                                  m: int.parse(mController.text),
                                  n: int.parse(nController.text),
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please Enter a number.'),
                      ));
                    }
                  },
                  child: const Text("Continue")),
            )
          ],
        ),
      ),
    );
  }
}
