import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/shared_widgets/app_cache_network_image.dart';
import '../../../core/shared_widgets/image_error_widget.dart';
import '../../../core/utils/string_util.dart';

class CardImage extends StatelessWidget {
  final String? imageUrl;
  const CardImage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == 'N/A') {
      return ImageErrorWidget(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(5.r),
        ),
        height: 120.h,
      );
    }
    if (StringUtil.isNotEmpty(imageUrl)) {
      return AppCacheNetworkImage(
        imageUrl: '$imageUrl',
        height: 150.h,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 150.h,
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5.r,
              ),
              image: DecorationImage(
                image: NetworkImage('$imageUrl'),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
    }
    return Container(
      height: 120.h,
      width: 200.w,
      alignment: Alignment.center,
      color: Colors.yellow,
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.black,
      ),
    );
  }
}
