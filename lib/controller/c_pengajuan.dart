import 'package:get/get.dart';
import 'package:project_kel9/model/pengajuan.dart';

class CPengajuan extends GetxController {
  Rx<Pengajuan> _pengajuan = Pengajuan().obs;

  Pengajuan get user => _pengajuan.value;

  void setUser(Pengajuan dataPengajuan) => _pengajuan.value = dataPengajuan;
}
