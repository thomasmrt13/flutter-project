import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/actions/image_service.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/users.dart';

class ProfileImageWidget extends StatefulWidget {

  const ProfileImageWidget({required this.user, super.key});
  final MyUser user;

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  late Future<Result<dynamic>> _imageFuture;

  @override
  Future<void> initState() async {
    super.initState();
    _imageFuture = ImageService().getUserProfileImageUrl(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FutureBuilder<Result<dynamic>>(
              future: _imageFuture,
              builder: (BuildContext context, AsyncSnapshot<Result<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading image');
                } else if (snapshot.hasData) {
                  final String imageUrl = snapshot.data.toString();
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  );
                }  else {
                  // Display a default image when no profile image is available
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/avatar.png'), // Set your default image asset path
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
