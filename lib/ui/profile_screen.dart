import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia/constants/constants.dart';
import 'package:vigenesia/models/user_model.dart';
import 'package:vigenesia/ui/edit_profile_screen.dart';
import 'package:vigenesia/ui/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? nama;
  const ProfileScreen({Key? key, this.nama}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<UserModel>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchMotivasiData();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff101010),
                      width: 0,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff00667B),
                        Color(0xff002F38),
                        Color(0xff101010),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("images/icon_arrow_left.png"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SplashScreen(),
                                  ),
                                );
                              },
                              child: Image.asset(
                                "images/icon_logout.png",
                                color: MyColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage("images/artists/default-profile.png"),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                height: 31,
                                width: 105,
                                decoration: BoxDecoration(
                                  color: const Color(0xff3E3F3F),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontFamily: "AB",
                                        color: MyColors.whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 65,
                              ),
                              FutureBuilder<List<UserModel>>(
                                future: fetchMotivasiData(),  // Ambil data dari API
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('No data available');
                                  } else {
                                    final userData = snapshot.data![0];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${userData.nama ?? 'Nama Lengkap'}',  // Data nama dari API
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 18,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Nama Lengkap",
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 15,
                                                color: MyColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '${userData.profesi ?? 'Profesi'}',  // Data profesi dari API
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 18,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Profesi",
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 15,
                                                color: MyColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '1',  // Data jumlah motivasi dari API
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 18,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Jumlah Motivasi",
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 15,
                                                color: MyColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff101010),
                      width: 0,
                    ),
                    color: const Color(0xff101010),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfilePlaylists extends StatelessWidget {
  const _ProfilePlaylists();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "See all playlists",
                style: TextStyle(
                  fontFamily: "AM",
                  fontSize: 15,
                  color: MyColors.whiteColor,
                ),
              ),
              Image.asset("images/icon_arrow_right.png"),
            ],
          ),
        ),
      ],
    );
  }
}

