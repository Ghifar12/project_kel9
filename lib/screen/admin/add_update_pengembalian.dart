import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';
import 'package:project_kel9/screen/admin/list_pengembalian.dart';
import 'package:project_kel9/widget/info.dart';

import '../../model/pengembalian.dart';

class AddUpdatePengembalian extends StatefulWidget {
  final Pengembalian? pengembalian;
  AddUpdatePengembalian({this.pengembalian});

  @override
  State<AddUpdatePengembalian> createState() => _AddUpdatePengembalianState();
}

class _AddUpdatePengembalianState extends State<AddUpdatePengembalian> {
  var _formKey = GlobalKey<FormState>();
  var _controllerKodePengembalian = TextEditingController();
  var _controllerKodePengajuan = TextEditingController();
  var _controllerTanggal = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.pengembalian != null) {
      _controllerKodePengembalian.text =
          widget.pengembalian!.kode_pengembalian!;
      _controllerKodePengajuan.text = widget.pengembalian!.kode_pengajuan!;
      _controllerTanggal.text = widget.pengembalian!.tanggal_kembali!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // titleSpacing: 0,
        title: Text('List Data Pengembalian'),
        backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerKodePengembalian,
                  decoration: InputDecoration(
                      labelText: "Kode Pengembalian",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerKodePengajuan,
                  decoration: InputDecoration(
                      labelText: "Kode Pengajuan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: widget.pengembalian == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerTanggal,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Kembali',
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
                          _controllerTanggal.text =
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.pengembalian == null) {
                        String message = await EventDb.addPengembalian(
                          _controllerKodePengembalian.text,
                          _controllerKodePengajuan.text,
                          _controllerTanggal.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerKodePengembalian.clear();
                          _controllerKodePengajuan.clear();
                          _controllerTanggal.clear();
                          Get.off(
                            ListPengembalian(),
                          );
                        }
                      } else {
                        EventDb.UpdatePengembalian(
                          _controllerKodePengembalian.text,
                          _controllerKodePengajuan.text,
                          _controllerTanggal.text,
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.pengembalian == null ? 'Simpan' : 'Ubah',
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
