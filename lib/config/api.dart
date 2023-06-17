class Api {
  static const _host = "http://192.168.100.19/api_project_kel9";

  static String _user = "$_host/user";
  static String _barang = "$_host/barang";
  static String _pengajuan = "$_host/pengajuan";
  static String _pengembalian = "$_host/pengembalian";

  static String login = "$_host/login.php";

  // user
  static String addUser = "$_user/add_user.php";
  static String deleteUser = "$_user/delete_user.php";
  static String getUsers = "$_user/get_users.php";
  static String updateUser = "$_user/update_user.php";

  static String addBarang = "$_barang/add_barang.php";
  static String deleteBarang = "$_barang/delete_barang.php";
  static String getBarang = "$_barang/get_barang.php";
  static String updateBarang = "$_barang/update_barang.php";

  static String addPengajuan = "$_pengajuan/add_pengajuan.php";
  static String deletePengajuan = "$_pengajuan/delete_pengajuan.php";
  static String getPengajuan = "$_pengajuan/get_pengajuan.php";
  static String updatePengajuan = "$_pengajuan/update_pengajuan.php";

  static String addPengembalian = "$_pengembalian/add_pengembalian.php";
  static String deletePengembalian = "$_pengembalian/delete_pengembalian.php";
  static String getPengembalian = "$_pengembalian/get_pengembalian.php";
  static String updatePengembalian = "$_pengembalian/update_pengembalian.php";
}
