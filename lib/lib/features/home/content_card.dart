import 'package:flutter/material.dart';
import 'content_detail_screen.dart';

class ContentCard extends StatelessWidget {
  final int index; 

  const ContentCard({
    super.key, 
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = 100.0;
    
    final uniqueTag = 'hero-image-$index'; 

    const fakeTitle = 'Title';
    const fakeDescription = 'Description example text...';
    const fakeImage = 'assets/images/test_image.jpg';

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContentDetailScreen(
              title: '$fakeTitle $index',
              description: fakeDescription,
              imagePath: fakeImage,
              heroTag: uniqueTag, 
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: uniqueTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  fakeImage,
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$fakeTitle $index',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: Text(
                      fakeDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
