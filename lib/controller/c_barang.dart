import 'package:get/get.dart';
import 'package:project_kel9/model/barang.dart';

class CBarang extends GetxController {
  Rx<Barang> _barang = Barang().obs;

  Barang get user => _barang.value;

  void setUser(Barang datadata_barang) => _barang.value = datadata_barang;
}
