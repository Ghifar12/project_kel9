import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/model/pengajuan.dart';
import 'package:project_kel9/screen/admin/add_update_pengajuan.dart';

class ListPengajuan extends StatefulWidget {
  @override
  State<ListPengajuan> createState() => _ListPengajuanState();
}

class _ListPengajuanState extends State<ListPengajuan> {
  List<Pengajuan> _listPengajuan = [];

  void getPengajuan() async {
    _listPengajuan = await EventDb.getPengajuan();

    setState(() {});
  }

  @override
  void initState() {
    getPengajuan();
    super.initState();
  }

  void showOption(Pengajuan? pengajuan) async {
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
        Get.to(AddUpdatePengajuan(pengajuan: pengajuan))
            ?.then((value) => getPengajuan());
        break;
      case 'delete':
        EventDb.deletePengajuan(pengajuan!.kode_pengajuan!)
            .then((value) => getPengajuan());
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
        title: Text('List Data Pengajuan'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listPengajuan.length > 0
              ? ListView.builder(
                  itemCount: _listPengajuan.length,
                  itemBuilder: (context, index) {
                    Pengajuan pengajuan = _listPengajuan[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(pengajuan.nama_peminjam ?? ''),
                      subtitle: Text(pengajuan.npm_peminjam ?? ''),
                      trailing: IconButton(
                          onPressed: () => showOption(pengajuan),
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
                  Get.to(AddUpdatePengajuan())?.then((value) => getPengajuan()),
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
