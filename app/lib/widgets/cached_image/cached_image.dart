import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;

  const CachedImage({Key key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(10.w),
        child: Container(
          width: 55.w,
          padding: EdgeInsets.all(
            20.w,
          ),
          child: Container(
            color: Cores.claro,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: 55.w,
        padding: EdgeInsets.all(
          5.w,
        ),
        child: Container(
          color: Cores.claro,
        ),
      ),
    );
  }
}
