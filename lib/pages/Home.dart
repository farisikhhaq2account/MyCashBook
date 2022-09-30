import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/pages/Detail_cash_flow.dart';
import 'package:mycashbook/pages/Pengaturan.dart';
import 'package:mycashbook/pages/Tambah_pemasukan.dart';
import 'package:mycashbook/pages/Tambah_pengeluaran.dart';
import 'package:mycashbook/widgets/Grid_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rangkuman Bulan ini"),
      ),
      body: SafeArea(
        child: Consumer<DBProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pemasukan: Rp " +
                      currencyFormatter.format(int.parse(
                          value.totalPengeluaran == "null"
                              ? "0"
                              : value.totalPengeluaran)),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Pengeluaran: Rp " +
                      currencyFormatter.format(int.parse(
                          value.totalPemasukan == "null"
                              ? "0"
                              : value.totalPemasukan)),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      GridCont(
                          destination: TambahPemasukan(),
                          featureName: "Tambah Pemasukan",
                          imgUrl: "assets/icons/income.png"),
                      GridCont(
                          destination: TambahPengeluaran(),
                          featureName: "Tambah Pengeluaran",
                          imgUrl: "assets/icons/outcome.png"),
                      GridCont(
                          destination: DetailCashFlow(),
                          featureName: "Detail Cash Flow",
                          imgUrl: "assets/icons/file.png"),
                      GridCont(
                        destination: Pengaturan(),
                        featureName: "Pengaturan",
                        imgUrl: "assets/icons/settings.png",
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
