import 'package:entertainmentguide/contants.dart';
import 'package:flutter/material.dart';

class MovieBox extends StatelessWidget {
  String imageUrl;
  String title;
  String description;
  Function onclick;

  MovieBox({this.imageUrl, this.title, this.description, this.onclick});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: width * 0.07),
      child: Container(
        height: 200.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffDAF0FE),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(color: searchBarContentColor)),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: FlatButton(
            onPressed: onclick,
            hoverColor: Color(0xffEDF6F9),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.network(
                imageUrl,
                width: width * 0.25,
                height: 160.0,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: width * 0.1),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: width * 0.3,
                      child: Text(title.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xff83c5be),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w100)),
                ],
              ),
// FlatButton(
//     onPressed: () {},
//     child: Icon(
//       Icons.favorite_border,
//       size: 5.0,
//     ))
            ]),
          ),
        ),
      ),
    );
  }
}
// Text.rich(
// TextSpan(
// text: title,
// style: TextStyle(
// fontSize: 12.0, fontWeight: FontWeight.bold),
// ),
// maxLines: 3,
// overflow: TextOverflow.ellipsis,
// textDirection: TextDirection.rtl,
// textAlign: TextAlign.justify,
// softWrap: true,
// ),
