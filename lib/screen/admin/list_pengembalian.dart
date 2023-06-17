import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/model/pengembalian.dart';
import 'package:project_kel9/screen/admin/add_update_pengembalian.dart';

class ListPengembalian extends StatefulWidget {
  @override
  State<ListPengembalian> createState() => _ListPengembalianState();
}

class _ListPengembalianState extends State<ListPengembalian> {
  List<Pengembalian> _listPengembalian = [];

  void getPengembalian() async {
    _listPengembalian = await EventDb.getPengembalian();
    setState(() {});
  }

  @override
  void initState() {
    getPengembalian();
    super.initState();
  }

  void showOption(Pengembalian? pengembalian) async {
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
        Get.to(AddUpdatePengembalian(pengembalian: pengembalian))
            ?.then((value) => getPengembalian());
        break;
      case 'delete':
        EventDb.deletePengembalian(pengembalian!.kode_pengembalian!)
            .then((value) => getPengembalian());
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
        title: Text('List Data Pengembalian'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listPengembalian.length > 0
              ? ListView.builder(
                  itemCount: _listPengembalian.length,
                  itemBuilder: (context, index) {
                    Pengembalian pengembalian = _listPengembalian[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(pengembalian.kode_pengembalian ?? ''),
                      subtitle: Text(pengembalian.tanggal_kembali ?? ''),
                      trailing: IconButton(
                          onPressed: () => showOption(pengembalian),
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
              onPressed: () => Get.to(AddUpdatePengembalian())
                  ?.then((value) => getPengembalian()),
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
