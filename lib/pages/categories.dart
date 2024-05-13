import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/lengthy_newa_model,dart';
import '../veiw_model/veiw_model_headline.dart';
import 'home.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  NewsVeiwModel newsVeiwModel = NewsVeiwModel();
  final format = DateFormat('MMMM dd,yyyy');
  String categoryName = 'General';
  List categoerieslist = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technologys',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
              width: width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoerieslist.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categoerieslist[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: height * 0.3,
                          width: width * .2,
                          decoration: BoxDecoration(
                            color: categoryName == categoerieslist[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(categoerieslist[index].toString(),
                                  style: GoogleFonts.poppins(fontSize: 13))),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<NewsLengthModel>(
                  future: newsVeiwModel.fetchNewsApi(categoryName),
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
      ),
    );
  }
}
