import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/model/barang.dart';
import 'package:project_kel9/screen/admin/add_update_barang.dart';

class ListBarang extends StatefulWidget {
  @override
  State<ListBarang> createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  List<Barang> _listBarang = [];

  void getBarang() async {
    _listBarang = await EventDb.getBarang();

    setState(() {});
  }

  @override
  void initState() {
    getBarang();
    super.initState();
  }

  void showOption(Barang? barang) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'update':
        Get.to(AddUpdateBarang(barang: barang))?.then((value) => getBarang());
        break;
      case 'delete':
        EventDb.deleteBarang(barang!.kode_barang!).then((value) => getBarang());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(
            colors: [Asset.colorPrimaryDark, Asset.colorPrimary]),
        // titleSpacing: 0,
        title: Text('List Data Barang'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listBarang.length > 0
              ? ListView.builder(
                  itemCount: _listBarang.length,
                  itemBuilder: (context, index) {
                    Barang barang = _listBarang[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(barang.nama_barang ?? ''),
                      subtitle: Text(barang.jumlah ?? ''),
                      trailing: IconButton(
                          onPressed: () => showOption(barang),
                          icon: Icon(Icons.more_vert)),
                    );
                  },
                )
              : Center(
                  child: Text("Data Kosong"),
                ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () =>
                  Get.to(AddUpdateBarang())?.then((value) => getBarang()),
              child: Icon(Icons.add),
              backgroundColor: Asset.colorAccent,
            ),
          )
        ],
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _defaultHeight = 56.0;

  final double elevation;
  final Gradient gradient;
  final Widget title;
  final double barHeight;

  GradientAppBar(
      {this.elevation = 3.0,
      required this.gradient,
      required this.title,
      this.barHeight = _defaultHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          offset: Offset(0, elevation),
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3,
        ),
      ]),
      child: AppBar(
        title: title,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
