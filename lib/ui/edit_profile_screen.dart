import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia/constants/constants.dart';
import 'package:vigenesia/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final String? nama;

  const EditProfileScreen({Key? key, this.nama}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  Future postRegister(
      String id, String nama, String profesi, String email, String password) async {
    var dio = Dio();

    dynamic data = {
      "id" : widget.nama,
      "nama": nama,
      "profesi" : profesi,
      "email" : email,
      "password" : password
    };

    try {
      final response = await dio.put("${MyColors.baseUrl}/api/Post_user/${widget.nama}",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  Future<List<UserModel>> fetchMotivasiData() async {
    final dio = Dio();
    String url = "${MyColors.baseUrl}/api/Get_user/${widget.nama}";

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load motivasi');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    namaController = TextEditingController();
    profesiController = TextEditingController();
    emailController = TextEditingController();
    _getMotivasiData();
  }

  Future<void> _getMotivasiData() async {
    try {
      List<UserModel> motivasiList = await fetchMotivasiData();
      if (motivasiList.isNotEmpty) {
        setState(() {
          idController.text = motivasiList[0].id ?? '';
          namaController.text = motivasiList[0].nama ?? '';
          profesiController.text = motivasiList[0].profesi ?? '';
          emailController.text = motivasiList[0].email ?? '';
        });
      }
    } catch (e) {
      print('Error fetching motivasi: $e');
    }
  }

  TextEditingController idController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darGreyColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const _Header(),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Nama",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: namaController,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Profesi",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: profesiController,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              GestureDetector(
                onTap: () async {
                  if (namaController.text.length != 0) {
                    await postRegister(
                        idController.text,
                        namaController.text,
                        profesiController.text,
                        emailController.text,
                        passwordController.text)
                        .then((value) => {
                      if (value != null)
                        {
                          setState(() {
                            Navigator.pop(context);
                            Flushbar(
                              message: "Profile berhasil diupdate",
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.black, // Dark background
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              borderRadius: BorderRadius.circular(10),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(15),
                              icon: Icon(
                                Icons.check_circle, // Icon yang menunjukkan keberhasilan
                                size: 28,
                                color: Colors.greenAccent,
                              ),
                              messageColor: Colors.white, // Warna teks pesan
                              title: "Berhasil", // Menambahkan judul (opsional)
                              titleColor: Colors.greenAccent, // Warna judul
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                ),
                              ],
                            ).show(context);
                          })
                        }
                    });
                  } else {
                    Flushbar(
                      message: "Profile harus diisi",
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.black, // Dark background
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      borderRadius: BorderRadius.circular(10),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      icon: Icon(
                        Icons.warning, // Icon yang menunjukkan keberhasilan
                        size: 28,
                        color: Colors.redAccent,
                      ),
                      messageColor: Colors.white, // Warna teks pesan
                      title: "Gagal", // Menambahkan judul (opsional)
                      titleColor: Colors.redAccent, // Warna judul
                      boxShadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ).show(context);
                  }
                },
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontFamily: "AB",
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.blackColor,
              ),
              child: Center(
                child: Image.asset(
                  "images/icon_arrow_left.png",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ),
          const Text(
            "Edit Profile",
            style: TextStyle(
              fontFamily: "AB",
              fontSize: 16,
              color: MyColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: 32,
            width: 32,
          ),
        ],
      ),
    );
  }
}
