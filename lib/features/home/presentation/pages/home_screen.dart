import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_comment/core/common/widgets/loader.dart';
import 'package:flutter_comment/core/constants/const_color.dart';
import 'package:flutter_comment/core/utils/mask_email.dart';
import 'package:flutter_comment/core/utils/snack_bar.dart';
import 'package:flutter_comment/features/home/presentation/bloc/fetch_data_bloc.dart';
import 'package:flutter_comment/features/home/presentation/widgets/text_flex.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  bool isLoading = false;

  initRemoteConfig() async {
    setState(() {
      isLoading = true;
    });
    await _remoteConfig.setDefaults({'MaskEmail': false});

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 10)));

    await _remoteConfig.fetchAndActivate();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initRemoteConfig();
    context.read<FetchDataBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
          title: const Text(
            'Comments',
            style: TextStyle(
                color: appWhite,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          backgroundColor: appBlue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: BlocConsumer<FetchDataBloc, FetchDataState>(
          listener: (context, state) {
            if (state is FetchDataFailure) {
              return showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is FetchDataLoading || isLoading) {
              return const Loader();
            }
            if (state is FetchDataSuccess) {
              return ListView.builder(
                  itemCount: state.dataModel.length,
                  itemBuilder: (context, index) {
                    final blog = state.dataModel[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(
                                'A',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    'Name',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Text(' : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.normal)),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(blog.name,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontStyle: FontStyle.normal)))
                                ]),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(children: [
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Text(' : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.normal)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                          _remoteConfig.getBool("MaskEmail")
                                              ? maskEmail(blog.email)
                                              : blog.email,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontStyle: FontStyle.normal)))
                                ]),
                                TextFlex(
                                    text: blog.body,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
