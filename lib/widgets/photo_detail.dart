import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoDetail extends StatefulWidget {
  String photo;

  PhotoDetail({
    required this.photo,
  });

  @override
  _PhotoDetailState createState() => new _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.photo),
          initialScale: PhotoViewComputedScale.contained * 1,
        );
      },
      itemCount: 1,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded /
                    event.expectedTotalBytes!.toInt(),
          ),
        ),
      ),
    );
  }
}
