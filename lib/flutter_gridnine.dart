library flutter_gridnine;

import 'package:flutter/material.dart';
import 'package:flutter_gridnine/indicator_decorator.dart';
import 'package:flutter_gridnine/indicator_line.dart';
import 'gridnine_model.dart';
export 'package:flutter_gridnine/gridnine_model.dart';
export 'indicator_line.dart';

class GridNine extends StatefulWidget {
  final bool loop;
  final double height;
  final num axisCount;
  final bool indicatorShow;
  final Color indicatorActiveColor;
  final Function(GNModel item) onTap;
  final List<GNModel> collection;

  GridNine({
    @required this.collection,
    this.loop = true,
    this.axisCount = 5,
    this.height = 170,
    this.onTap,
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: widget.height,
            child: PageView(
              children: _buildPageItem(widget.collection),
              onPageChanged:(_index){
                setState(() {
                  this.index = _index;
                });
              },
            ),
          ),
          Offstage(
            offstage: !widget.indicatorShow,
            child:IndicatorLine(
              dotsCount:dotCount,
              position: index,
              decorator: IndicatorDecorator(
                activeColor:widget.indicatorActiveColor,
                size: const Size(20, 1.5),
                activeSize: const Size(20, 1.5),
                shape: RoundedRectangleBorder(),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: GridView(
            scrollDirection: Axis.vertical,
            physics: FixedExtentScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.axisCount,
              childAspectRatio: 0.9
            ),
            children: _buildItem(
              items.sublist(index * pageItemCount, index * pageItemCount + pageItemCount),
            ),
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
              childAspectRatio: 0.9,
            ),
            children: _buildItem(
              items.sublist(index * pageItemCount, index * pageItemCount + remainCount),
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
          child: Container(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    items[i].url,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
                Text(
                  items[i].title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
                Text(
                  items[i].description,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    return widgets;
  }
}
