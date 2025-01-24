  import 'package:another_flushbar/flushbar.dart';
  import 'package:dio/dio.dart';
  import 'package:flutter/material.dart';
  import 'package:vigenesia/constants/constants.dart';

  class AddMotivasionScreen extends StatefulWidget {
    final String? nama;
    const AddMotivasionScreen({Key? key, this.nama}) : super(key: key);
  
    @override
    State<AddMotivasionScreen> createState() => _AddMotivasionScreenState();
  }
  
  class _AddMotivasionScreenState extends State<AddMotivasionScreen> {
  
    Future postRegister(
        String nama, String motivasi) async {
      var dio = Dio();
  
      dynamic data = {
        "nama" : widget.nama,
        "motivasi": motivasi,
      };
  
      try {
        final response = await dio.post("${MyColors.baseUrl}/api/Post_motivasi/",
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
  
    TextEditingController namaController = TextEditingController();
    TextEditingController motivasiController = TextEditingController();
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
                      "Motivation",
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
                    controller: motivasiController,
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
                    if (motivasiController.text.length != 0) {
                      await postRegister(
                          namaController.text,
                          motivasiController.text)
                          .then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              Navigator.pop(context);
                              Flushbar(
                                message: "Motivasi berhasil ditambahkan",
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
                        message: "Motivasi harus diisi",
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
                        "Add",
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
              "Add Motivation",
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
