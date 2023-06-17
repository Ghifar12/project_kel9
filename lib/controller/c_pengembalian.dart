import 'package:get/get.dart';
import 'package:project_kel9/model/pengembalian.dart';

class CPengembalian extends GetxController {
  Rx<Pengembalian> _pengembalian = Pengembalian().obs;

  Pengembalian get user => _pengembalian.value;

  void setUser(Pengembalian dataPengembalian) =>
      _pengembalian.value = dataPengembalian;
}
