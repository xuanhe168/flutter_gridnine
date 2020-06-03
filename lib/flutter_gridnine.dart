library flutter_gridnine;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gridnine/indicator_decorator.dart';
import 'package:flutter_gridnine/indicator_line.dart';
import 'gridnine_model.dart';
export 'package:flutter_gridnine/gridnine_model.dart';
export 'indicator_line.dart';

class GridNine extends StatefulWidget {
  final bool loop;
  final Color color;
  final num axisCount;
  final Decoration decoration;
  final bool indicatorShow;
  final Color indicatorActiveColor;
  final Function(GNModel item) onTap;
  final List<GNModel> collection;

  GridNine({
    @required this.collection,
    this.loop = true,
    this.axisCount = 4,
    this.onTap,
    this.decoration,
    this.color = Colors.transparent,
    this.indicatorShow = false,
    this.indicatorActiveColor = Colors.red,
  });

  @override
  State<StatefulWidget> createState() => new _GridNine();
}

class _GridNine extends State<GridNine> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    int rowCount = widget.axisCount;
    int dotCount = widget.collection.length ~/ (rowCount * 2);
    dotCount += widget.collection.length % (rowCount * 2) > 0 ? 1 : 0;
    return Container(
      color:widget.color,
      padding: EdgeInsets.only(bottom: 20),
      decoration: widget.decoration,
      height: widget.indicatorShow ? (widget.collection.length != widget.axisCount &&
          widget.collection.length / widget.axisCount > 0 ? 240 : 120) :
      (widget.collection.length != widget.axisCount &&
          widget.collection.length / widget.axisCount > 0 ? 240 : 120) - 10.00,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: PageView(
              children: _buildPageItem(widget.collection),
              onPageChanged: (_index) {
                setState(() {
                  this.index = _index;
                });
              },
            ),
          ),
          Offstage(
            offstage: !widget.indicatorShow,
            child: IndicatorLine(
              dotsCount: dotCount,
              position: index,
              decorator: IndicatorDecorator(
                activeColor: widget.indicatorActiveColor,
                size: const Size(20, 1.5),
                activeSize: const Size(20, 1.5),
                shape: RoundedRectangleBorder(),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageItem(List<GNModel> items) {
    List<Widget> widgets = new List<Widget>();
    num pageItemCount = widget.axisCount * 2;
    num pageCount = items.length / pageItemCount;
    num remainCount = items.length % pageItemCount;
    num index = 0;
    for (index = 0; index < pageCount.toInt(); index++)
      widgets.add(
        GridView(
          scrollDirection: Axis.vertical,
          physics: FixedExtentScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.axisCount,
            childAspectRatio: 0.9,
          ),
          children: _buildItem(
            items.sublist(
                index * pageItemCount, index * pageItemCount + pageItemCount),
          ),
        ),
      );
    if (remainCount > 0) {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: GridView(
            scrollDirection: Axis.vertical,
            physics: FixedExtentScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.axisCount,
            ),
            children: _buildItem(
              items.sublist(
                  index * pageItemCount, index * pageItemCount + remainCount),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _buildItem(List<GNModel> items) {
    List<Widget> widgets = new List<Widget>();
    for (num i = 0; i < items.length; i++)
      widgets.add(
        InkWell(
          onTap: () => widget.onTap(items[i]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: items[i].getIconUrl(),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    );
                  },
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(
                items[i].getTitle(),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              Offstage(
                offstage: items[i].getSubTitle() == null ||
                        items[i].getSubTitle() == ""
                    ? true
                    : false,
                child: Text(
                  items[i].getSubTitle() == null || items[i].getSubTitle() == ""
                      ? ""
                      : items[i].getSubTitle(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    return widgets;
  }
}
