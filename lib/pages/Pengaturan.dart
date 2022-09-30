import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_acc_provider.dart';
import 'package:mycashbook/model/Account.dart';
import 'package:provider/provider.dart';

class Pengaturan extends StatelessWidget {
  TextEditingController pass = new TextEditingController();
  TextEditingController newPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Pengaturan"),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<AccProvider>(builder: (context, acc, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Password Saat ini", "cth: user", pass),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Password Baru", "cth: user1", newPass),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      acc.checkPass(pass.text);
                      if (acc.isChecked) {
                        if (newPass.text.isNotEmpty) {
                          acc.changePass(pass.text, newPass.text);
                          SnackBar snackBar = SnackBar(
                              content: Text("Password berhasil diubah"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          SnackBar snackBar = SnackBar(
                              content: Text("Isi kolom password baru"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        SnackBar snackBar =
                            SnackBar(content: Text("Password lama salah"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("Simpan")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kembali")),
              ),
              Spacer(),
              Container(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FittedBox(
                          child: Image.asset("assets/icons/user.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "About this App",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text("Aplikasi ini dibuat oleh" +
                            "\nNama: Faris Ikhlasul Haq" +
                            "\nNIM: 1941720062" +
                            "\nTanggal: 27 September 2022"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget myTextField(BuildContext context, String label, hint,
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
            obscureText: true,
            decoration: InputDecoration(
                hintText: hint, isDense: true, border: InputBorder.none),
          )
        ],
      ),
    );
  }
}
