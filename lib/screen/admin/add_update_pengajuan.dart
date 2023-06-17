import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/screen/admin/list_pengajuan.dart';
import 'package:project_kel9/widget/info.dart';

import '../../model/pengajuan.dart';

class AddUpdatePengajuan extends StatefulWidget {
  final Pengajuan? pengajuan;
  AddUpdatePengajuan({this.pengajuan});

  @override
  State<AddUpdatePengajuan> createState() => _AddUpdatePengajuanState();
}

class _AddUpdatePengajuanState extends State<AddUpdatePengajuan> {
  var _formKey = GlobalKey<FormState>();
  var _controllerkode_pengajuan = TextEditingController();
  var _controllertanggal = TextEditingController();
  var _controllernpm_peminjam = TextEditingController();
  var _controllernama_peminjam = TextEditingController();
  var _controllerprodi = TextEditingController();
  var _controllerno_handphone = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.pengajuan != null) {
      _controllerkode_pengajuan.text = widget.pengajuan!.kode_pengajuan!;
      _controllertanggal.text = widget.pengajuan!.tanggal!;
      _controllernpm_peminjam.text = widget.pengajuan!.npm_peminjam!;
      _controllernama_peminjam.text = widget.pengajuan!.nama_peminjam!;
      _controllerprodi.text = widget.pengajuan!.prodi!;
      _controllerno_handphone.text = widget.pengajuan!.no_handphone!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GradientAppBar(
        gradient: LinearGradient(
            colors: [Asset.colorPrimaryDark, Asset.colorPrimary]),
        // titleSpacing: 0,
        title: widget.pengajuan != null
            ? Text('Update Pengajuan')
            : Text('Tambah Pengajuan'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  enabled: widget.pengajuan == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerkode_pengajuan,
                  decoration: InputDecoration(
                      labelText: "Kode Pengajuan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: widget.pengajuan == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllertanggal,
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    hintText: 'Pilih Tanggal',
                    prefixIcon: Icon(Icons.calendar_today),
                    iconColor: Asset.colorSecoundary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        // Lakukan sesuatu dengan tanggal yang dipilih
                        // Misalnya, simpan ke variabel atau lakukan validasi
                        setState(() {
                          _controllertanggal.text =
                              formattedDate; // Set nilai teks di TextFormField
                        });
                      }
                    });
                  },
                  readOnly: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllernpm_peminjam,
                  decoration: InputDecoration(
                      labelText: "NPM",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllernama_peminjam,
                  decoration: InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerprodi,
                  decoration: InputDecoration(
                      labelText: "Prodi",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerno_handphone,
                  decoration: InputDecoration(
                      labelText: "No Handphone",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.pengajuan == null) {
                        String message = await EventDb.AddPengajuan(
                          _controllerkode_pengajuan.text,
                          _controllertanggal.text,
                          _controllernpm_peminjam.text,
                          _controllernama_peminjam.text,
                          _controllerprodi.text,
                          _controllerno_handphone.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerkode_pengajuan.clear();
                          _controllertanggal.clear();
                          _controllernpm_peminjam.clear();
                          _controllernama_peminjam.clear();
                          _controllerprodi.clear();
                          _controllerno_handphone.clear();
                          Get.off(
                            ListPengajuan(),
                          );
                        }
                      } else {
                        EventDb.UpdatePengajuan(
                          _controllerkode_pengajuan.text,
                          _controllertanggal.text,
                          _controllernpm_peminjam.text,
                          _controllernama_peminjam.text,
                          _controllerprodi.text,
                          _controllerno_handphone.text,
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.pengajuan == null ? 'Simpan' : 'Ubah',
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isHidden', _isHidden));
  }
}
