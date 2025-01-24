import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia/ui/edit_motivasion_screen.dart';
import 'package:vigenesia/ui/profile_screen.dart';
import 'package:vigenesia/ui/setting_screen.dart';
import '../constants/constants.dart';
import '../models/motivasi_model.dart';
import 'add_motivasion_screen.dart';

class LibraryScreen extends StatefulWidget {
  final String? nama;

  const LibraryScreen({Key? key, this.nama}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<MotivasiModel>> _motivasiFuture;

  @override
  void initState() {
    super.initState();
    _motivasiFuture = fetchMotivasiData();
  }

  Future<List<MotivasiModel>> fetchMotivasiData() async {
    final dio = Dio();
    String url = "${MyColors.baseUrl}/api/Get_motivasi/${widget.nama}";

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => MotivasiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load motivasi');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  void _refreshMotivasi() {
    setState(() {
      _motivasiFuture = fetchMotivasiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingScreen(),
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage("images/artists/default-profile.png"),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'My Motivations',
                                  style: TextStyle(
                                    fontFamily: "AB",
                                    fontSize: 24,
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddMotivasionScreen(nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: Image.asset("images/icon_add.png"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: Image.asset("images/icon_settings.png"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/arrow_component_down.png",
                                    width: 10,
                                    height: 12,
                                  ),
                                  Image.asset(
                                    "images/arrow_component_up.png",
                                    width: 10,
                                    height: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Recently Added",
                                style: TextStyle(
                                  fontFamily: "AM",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _refreshMotivasi,
                            child: Image.asset('images/icon-refresh.png'),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FutureBuilder<List<MotivasiModel>>(
                      future: fetchMotivasiData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No motivasi available.', style: TextStyle(color: MyColors.whiteColor)));
                        } else {
                          final motivasiList = snapshot.data!;
                          return Column(
                            children: List.generate(motivasiList.length, (index) {
                              final motivasi = motivasiList[index];
                              return Card(
                                color: MyColors.blackColor,
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditMotivasionScreen(id: motivasi.id),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage('images/artists/default-profile.png'),
                                      ),
                                      title: Text(
                                        motivasi.isiMotivasi ?? 'Unknown',
                                        style: TextStyle(color: MyColors.whiteColor),
                                      ),
                                      subtitle: Text(
                                        motivasi.nama ?? 'user',
                                        style: TextStyle(color: MyColors.lightGrey),
                                      ),
                                    ),
                                  )
                              );
                            }),
                          );
                        }
                      },
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 130),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewEpisodesSection extends StatelessWidget {
  const _NewEpisodesSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset("images/new_episods.png"),
                Image.asset("images/icon_bell_fill.png"),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "New Episods",
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 15,
                    color: MyColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Image.asset("images/icon_pin.png"),
                    const SizedBox(width: 5),
                    const Text(
                      "Updated 2 days ago",
                      style: TextStyle(
                        fontFamily: "AM",
                        color: MyColors.lightGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LikedSongsSection extends StatelessWidget {
  const _LikedSongsSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset("images/liked_songs.png"),
                Image.asset("images/icon_heart_white.png"),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Liked Songs",
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 15,
                    color: MyColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Image.asset("images/icon_pin.png"),
                    const SizedBox(width: 5),
                    const Text(
                      "Playlist . 58 songs",
                      style: TextStyle(
                        fontFamily: "AM",
                        color: MyColors.lightGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
