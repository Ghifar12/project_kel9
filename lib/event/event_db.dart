import 'dart:convert';
import 'package:get/get.dart';
import 'package:project_kel9/config/api.dart';
import 'package:project_kel9/event/event_pref.dart';
import 'package:project_kel9/model/barang.dart';
import 'package:project_kel9/model/pengajuan.dart';
import 'package:project_kel9/model/pengembalian.dart';
import 'package:project_kel9/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:project_kel9/screen/admin/dashbord_admin.dart';
import 'package:project_kel9/widget/info.dart';

class EventDb {
  static Future<User?> login(String username, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'username': username,
        'pass': pass,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);

        if (responBody['success']) {
          user = User.fromJson(responBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700), () {
            Get.off(
              DashboardAdmin(),
            );
          });
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<List<User>> getUser() async {
    List<User> listUser = [];

    try {
      var response = await http.get(Uri.parse(Api.getUsers));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var users = responBody['user'];

          users.forEach((user) {
            listUser.add(User.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listUser;
  }

  static Future<String> addUser(
      String name, String username, String pass, String role) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addUser), body: {
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add User Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateUser(
    String id,
    String name,
    String username,
    String pass,
    String role,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updateUser), body: {
        'id': id,
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update User');
        } else {
          Info.snackbar('Gagal Update User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteUser(String id) async {
    try {
      var response =
          await http.post(Uri.parse(Api.deleteUser), body: {'id': id});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete User');
        } else {
          Info.snackbar('Gagal Delete User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Barang>> getBarang() async {
    List<Barang> listDataBarang = [];

    try {
      var response = await http.get(Uri.parse(Api.getBarang));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var barang = responBody['barang'];

          barang.forEach((barang) {
            listDataBarang.add(Barang.fromJson(barang));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listDataBarang;
  }

  static Future<String> AddBarang(
      String kode_barang, String nama_barang, String jumlah) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addBarang), body: {
        'kode_barang': kode_barang,
        'nama_barang': nama_barang,
        'jumlah': jumlah
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Data Barang Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateBarang(
      String kode_barang, String nama_barang, String jumlah) async {
    try {
      var response = await http.post(Uri.parse(Api.updateBarang), body: {
        'kode_barang': kode_barang,
        'nama_barang': nama_barang,
        'jumlah': jumlah
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Data Barang');
        } else {
          Info.snackbar('Gagal Update Data Barang');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteBarang(String kode_barang) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteBarang),
          body: {'kode_barang': kode_barang});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Data Barang');
        } else {
          Info.snackbar('Gagal Delete Data Barang');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Pengajuan>> getPengajuan() async {
    List<Pengajuan> listPengajuan = [];

    try {
      var response = await http.get(Uri.parse(Api.getPengajuan));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var pengajuan = responBody['pengajuan'];

          pengajuan.forEach((pengajuan) {
            listPengajuan.add(Pengajuan.fromJson(pengajuan));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listPengajuan;
  }

  static Future<String> AddPengajuan(
      String kode_pengajuan,
      String tanggal,
      String npm_peminjam,
      String nama_peminjam,
      String prodi,
      String no_handphone) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addPengajuan), body: {
        'kode_pengajuan': kode_pengajuan,
        'tanggal': tanggal,
        'npm_peminjam': npm_peminjam,
        'nama_peminjam': nama_peminjam,
        'prodi': prodi,
        'no_handphone': no_handphone,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Data Pengajuan Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdatePengajuan(
      String kode_pengajuan,
      String tanggal,
      String npm_peminjam,
      String nama_peminjam,
      String prodi,
      String no_handphone) async {
    try {
      var response = await http.post(Uri.parse(Api.updatePengajuan), body: {
        'kode_pengajuan': kode_pengajuan,
        'tanggal': tanggal,
        'npm_peminjam': npm_peminjam,
        'nama_peminjam': nama_peminjam,
        'prodi': prodi,
        'no_handphone': no_handphone,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Data Pengajuan');
        } else {
          Info.snackbar('Gagal Update Data Pengajuan');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deletePengajuan(String kode_pengajuan) async {
    try {
      var response = await http.post(Uri.parse(Api.deletePengajuan),
          body: {'kode_pengajuan': kode_pengajuan});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Data Pengajuan');
        } else {
          Info.snackbar('Gagal Delete Data Pengajuan');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Pengembalian>> getPengembalian() async {
    List<Pengembalian> listPengembalian = [];

    try {
      var response = await http.get(Uri.parse(Api.getPengembalian));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var pengembalian = responBody['pengembalian'];

          pengembalian.forEach((pengembalian) {
            listPengembalian.add(Pengembalian.fromJson(pengembalian));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listPengembalian;
  }

  static Future<String> addPengembalian(String kode_pengembalian,
      String kode_pengajuan, String tanggal_kembali) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addPengembalian), body: {
        'kode_pengembalian': kode_pengembalian,
        'kode_pengajuan': kode_pengajuan,
        'tanggal_kembali': tanggal_kembali,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Data Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdatePengembalian(String kode_pengembalian,
      String kode_pengajuan, String tanggal_kembali) async {
    try {
      var response = await http.post(Uri.parse(Api.updatePengembalian), body: {
        'kode_pengembalian': kode_pengembalian,
        'kode_pengajuan': kode_pengajuan,
        'tanggal_kembali': tanggal_kembali,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Data');
        } else {
          Info.snackbar('Gagal Update Data');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deletePengembalian(String kode_pengembalian) async {
    try {
      var response = await http.post(Uri.parse(Api.deletePengembalian),
          body: {'kode_pengembalian': kode_pengembalian});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Data');
        } else {
          Info.snackbar('Gagal Delete Data');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
