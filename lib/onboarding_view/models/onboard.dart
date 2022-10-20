import '../../constants/app_constants.dart';

class Onboard{
  final String image;
  final String title;
  final String description;

  Onboard({
    required this.image,
    required this.title,
    required this.description});
}

final List<Onboard> contents=[
  Onboard(
      image:'assets/images/image1.png',
      title:AppConstants.title1,
      description:AppConstants.description1),
  Onboard(image: 'assets/images/image3.png',
      title: AppConstants.title2,
      description: AppConstants.description2),
  Onboard(image: 'assets/images/image2.png',
      title: AppConstants.title3,
      description: AppConstants.description3),
];