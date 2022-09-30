import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_acc_provider.dart';
import 'package:mycashbook/pages/Home.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController username = TextEditingController(text: "user");

  TextEditingController pass = TextEditingController(text: "user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<AccProvider>(builder: (context, acc, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/finance.png",
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Faris's Cashbook 1.0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  myTextField(context, "Username", "", false, username),
                  SizedBox(
                    height: 24,
                  ),
                  myTextField(context, "Password", "", true, pass),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16)),
                      onPressed: () async {
                        await acc.checkPass(pass.text);
                        if (acc.isChecked) {
                          if (username.text != "user") {
                            SnackBar snackBar = SnackBar(
                                content: Text("Username tidak ditemukan"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          }
                        } else {
                          SnackBar snackBar =
                              SnackBar(content: Text("Password salah"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget myTextField(BuildContext context, String label, hint, bool isPassword,
      TextEditingController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          ),
          TextField(
            style: TextStyle(fontWeight: FontWeight.bold),
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hint, isDense: true, border: InputBorder.none),
          )
        ],
      ),
    );
  }
}
