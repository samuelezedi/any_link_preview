import 'package:flutter/material.dart';

class LinkViewVertical extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final ImageProvider? imageProvider;
  final Function() onTap;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final bool? showMultiMedia;
  final TextOverflow? bodyTextOverflow;
  final int? bodyMaxLines;
  final double? radius;
  final Color? bgColor;
  final bool custom;

  LinkViewVertical({
    Key? key,
    required this.url,
    required this.title,
    required this.description,
    required this.imageProvider,
    required this.onTap,
    required this.custom,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.bgColor,
    this.radius,
  }) : super(key: key);

  double computeTitleFontSize(double height) {
    var size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight, layoutWidth) {
    return layoutHeight - layoutWidth < 50 ? 1 : 2;
  }

  int? computeBodyLines(layoutHeight) {
    return layoutHeight ~/ 60 == 0 ? 1 : layoutHeight ~/ 60;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var titleTS_ = titleTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          );
      var bodyTS_ = bodyTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight) - 1,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          );

      return InkWell(
          onTap: () => onTap(),
          child: custom
              ? _customContainer(
                  titleTS_: titleTS_,
                  bodyTS_: bodyTS_,
                  layoutWidth: layoutWidth,
                  layoutHeight: layoutHeight)
              : Column(
                  children: <Widget>[
                    showMultiMedia!
                        ? Expanded(
                            flex: 2,
                            child: imageProvider == null
                                ? Container(color: bgColor ?? Colors.grey)
                                : Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: radius == 0
                                          ? BorderRadius.zero
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                      image: DecorationImage(
                                        image: imageProvider!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                          )
                        : SizedBox(height: 5),
                    _buildTitleContainer(
                        titleTS_, computeTitleLines(layoutHeight, layoutWidth)),
                    _buildBodyContainer(
                        bodyTS_, computeBodyLines(layoutHeight)),
                  ],
                ));
    });
  }

  Widget _buildTitleContainer(TextStyle titleTS_, int? maxLines_) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 1),
      child: Container(
        alignment: Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: titleTS_,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines_,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContainer(TextStyle bodyTS_, int? maxLines_) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
        child: Container(
          alignment: Alignment(-1.0, -1.0),
          child: Text(
            description,
            style: bodyTS_,
            overflow: bodyTextOverflow ?? TextOverflow.ellipsis,
            maxLines: bodyMaxLines ?? maxLines_,
          ),
        ),
      ),
    );
  }

  Widget _customContainer({
    required TextStyle titleTS_,
    required TextStyle bodyTS_,
    required double layoutWidth,
    required double layoutHeight,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey,
        borderRadius:
            radius == 0 ? BorderRadius.zero : BorderRadius.circular(12),
        image: DecorationImage(
          image: imageProvider!,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12))),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleTS_.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.open_in_new,
                    size: 15,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(child: Text(description, style: bodyTS_)),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
