import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/model/Cash.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TambahPemasukan extends StatefulWidget {
  const TambahPemasukan({Key? key}) : super(key: key);

  @override
  State<TambahPemasukan> createState() => _TambahPemasukanState();
}

class _TambahPemasukanState extends State<TambahPemasukan> {
  DateTime date = DateTime.now();

  TextEditingController nominal = new TextEditingController(text: "");
  TextEditingController keterangan = new TextEditingController(text: "");
  String temp = "";

  @override
  Widget build(BuildContext context) {
    temp = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pemasukan"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Text('${date.day}/${date.month}/${date.year}'),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() {
                            date = newDate;
                            temp = '${date.day}/${date.month}/${date.year}';
                          });
                        },
                        child: Text("Pick Date")),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Nominal", "Cth: 10000", nominal, true),
              SizedBox(
                height: 16,
              ),
              myTextField(context, "Keterangan", "Cth: Magang Semester 7",
                  keterangan, false),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (nominal.text != "") {
                        final snackBar =
                            SnackBar(content: Text("Pemasukan telah diisi"));
                        final cash = Cash(
                            id: Uuid().v1().toString(),
                            nominal: int.parse(nominal.text),
                            keterangan: keterangan.text,
                            date: temp,
                            isAdd: true);
                        print(cash.isAdd);
                        Provider.of<DBProvider>(context, listen: false)
                            .addCash(cash);
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                            content: Text("Isi nominalnya terlebih dahulu"));
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(BuildContext context, String label, hint,
      TextEditingController controller, bool isNumber) {
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
            keyboardType: isNumber ? TextInputType.number : null,
            style: TextStyle(fontWeight: FontWeight.bold),
            controller: controller,
            decoration: InputDecoration(
                hintText: hint, isDense: true, border: InputBorder.none),
          )
        ],
      ),
    );
  }
}
