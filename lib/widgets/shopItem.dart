import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    this.text,
    this.image,
    this.color,
  });

  final String text;
  final Image image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
      child: Material(
        type: MaterialType.card,
        elevation: 1,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0)),
        clipBehavior: Clip.antiAlias,
        color: color,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        text,
                        style: TextStyle(
                          color: color.computeLuminance() > 0.5
                              ? Colors.black54
                              : Colors.white70,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              image,
            ],
          ),
        ),
      ),
    );
  }
}
