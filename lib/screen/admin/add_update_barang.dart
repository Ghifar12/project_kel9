// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/screen/admin/list_barang.dart';
import 'package:project_kel9/widget/info.dart';

import '../../model/barang.dart';

class AddUpdateBarang extends StatefulWidget {
  final Barang? barang;
  AddUpdateBarang({this.barang});

  @override
  State<AddUpdateBarang> createState() => _AddUpdateBarangState();
}

class _AddUpdateBarangState extends State<AddUpdateBarang> {
  var _formKey = GlobalKey<FormState>();
  var _controllerKodeBarang = TextEditingController();
  var _controllerNamaBarang = TextEditingController();
  var _controllerJumlah = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.barang != null) {
      _controllerKodeBarang.text = widget.barang!.kode_barang!;
      _controllerNamaBarang.text = widget.barang!.nama_barang!;
      _controllerJumlah.text = widget.barang!.jumlah!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // titleSpacing: 0,
        title: widget.barang != null
            ? Text('Update Data Barang')
            : Text('Tambah Data Barang'),
        backgroundColor: Asset.colorPrimaryDark,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  enabled: widget.barang == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerKodeBarang,
                  decoration: InputDecoration(
                      labelText: "Kode Barang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNamaBarang,
                  decoration: InputDecoration(
                      labelText: "Nama Barang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerJumlah,
                  decoration: InputDecoration(
                      labelText: "Jumlah",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.barang == null) {
                        String message = await EventDb.AddBarang(
                          _controllerKodeBarang.text,
                          _controllerNamaBarang.text,
                          _controllerJumlah.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerKodeBarang.clear();
                          _controllerNamaBarang.clear();
                          _controllerJumlah.clear();
                          Get.off(
                            ListBarang(),
                          );
                        }
                      } else {
                        EventDb.UpdateBarang(
                          _controllerKodeBarang.text,
                          _controllerNamaBarang.text,
                          _controllerJumlah.text,
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.barang == null ? 'Simpan' : 'Ubah',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Asset.colorAccent,
                      fixedSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
