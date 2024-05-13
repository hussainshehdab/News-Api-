import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_apis/model/headline_model.dart';
import 'package:news_app_apis/pages/categories.dart';

import '../model/lengthy_newa_model,dart';
import '../veiw_model/veiw_model_headline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  independent,
  reuter,
  cnn,
  alJazeera,
  bbcsport,
  espn,
  foxnews,
  googlenews
}

class _HomeScreenState extends State<HomeScreen> {
  NewsVeiwModel newsVeiwModel = NewsVeiwModel();
  final format = DateFormat('MMMM dd,yyyy');
  String name = 'fox-news';
  FilterList? selectedMenu;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyCategory()));
          },
          icon: Image.asset('assets/category_icon.png'),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                if (FilterList.bbcsport.name == item.name) {
                  name = 'bbc-sport';
                }
                if (FilterList.espn.name == item.name) {
                  name = 'espn';
                }
                if (FilterList.foxnews.name == item.name) {
                  name = 'fox-news';
                }
                if (FilterList.googlenews.name == item.name) {
                  name = 'google-news';
                }
                if (FilterList.independent.name == item.name) {
                  name = 'independent';
                }
                newsVeiwModel.getapi();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              initialValue: selectedMenu,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    const PopupMenuItem(
                        value: FilterList.aryNews, child: Text('ARY News')),
                    const PopupMenuItem(
                        value: FilterList.cnn, child: Text('CNN')),
                    const PopupMenuItem(
                        value: FilterList.bbcsport, child: Text('BBC sports')),
                    const PopupMenuItem(
                        value: FilterList.espn, child: Text('ESPN')),
                    const PopupMenuItem(
                        value: FilterList.foxnews, child: Text('Fox News')),
                    const PopupMenuItem(
                        value: FilterList.googlenews,
                        child: Text('Google News')),
                    const PopupMenuItem(
                        value: FilterList.independent,
                        child: Text('Independent News')),
                    const PopupMenuItem(
                        value: FilterList.aryNews, child: Text('ARY News')),
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: width,
            height: height * .55,
            child: FutureBuilder<NewsHeadlineModel>(
                future: newsVeiwModel.getapi(),
                builder: (BuildContext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(
                      color: Colors.blue,
                      size: 40,
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height * .02,
                                horizontal: width * .03),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * .02,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => spinkit2,
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          height: height * .22,
                                          alignment: Alignment.bottomCenter,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: width * .7,
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: width * .7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      format.format(dateTime),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
          Expanded(
            child: FutureBuilder<NewsLengthModel>(
                future: newsVeiwModel.fetchNewsApi('General'),
                builder: (BuildContext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(
                      color: Colors.blue,
                      size: 40,
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    height: height * .18,
                                    width: width * .3,
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => spinkit2,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 12),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        maxLines: 3,
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.red,
  size: 50,
);
