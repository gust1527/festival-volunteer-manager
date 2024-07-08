import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:festival_volunteer_application/Utility/UserHandler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _getImagePath(String artistName) {
  switch (artistName.toLowerCase()) {
    case "aphaca":
      return 'assets/images/Aphaca.jpg';
    case "storebjerg":
      return 'assets/images/Storebjerg.png';
    case "aysay":
      return 'assets/images/Aysay.jpg';
    case "døtre":
      return 'assets/images/Døtre.png';
    case "elsked":
      return 'assets/images/Elsked.jpg';
    case "iiris":
      return 'assets/images/Iiris.png';
    case "pradanøia":
      return 'assets/images/Pradanøia.jpg';
    case "tigeroak":
      return 'assets/images/Tigeroak.png';
    default:
      return 'assets/images/app_icon.png';
  }
}

String _getFormattedTime(DateTime artistTime) {
  // Extract weekday from DateTime object
  String convertedTime = DateFormat('EEEE @ HH:mm', 'da_DK').format(artistTime);

  // Capitalize the first letter
  convertedTime = convertedTime.substring(0, 1).toUpperCase() + convertedTime.substring(1);

  // Return the first three letters of the weekday
  return convertedTime;
}


class ArtistWidget extends StatefulWidget {
  final Artist artist;
  bool favorite = false;

  ArtistWidget(this.artist);

  @override
  _ArtistWidgetState createState() => _ArtistWidgetState();
}

class _ArtistWidgetState extends State<ArtistWidget> {
  late String imagePath;
  late Widget artistImage;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    imagePath = _getImagePath(widget.artist.name);
    formattedTime = _getFormattedTime(widget.artist.time);
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(imagePath);
    return GestureDetector(
      child: ListTile(
        leading: image,
        title: Text(
          widget.artist.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OedstedFestival'
          ),
        ),
        subtitle: Text(
            formattedTime),
        trailing: IconButton(
            icon: Icon(widget.favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => setState(() {
              widget.favorite = !widget.favorite;
            })
        ),
        minVerticalPadding: 0,
      ),
      onTap: () {
        GlobalHandler().artist = widget.artist;
        Navigator.pushNamed(context, "/music/${widget.artist.name}");
      },
    );
  }
}

class Artist {
  final String name;
  final DateTime time;
  Artist({required this.name, required this.time});
}

class ArtistPage extends StatelessWidget {

  const ArtistPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar.withOtherTitle(GlobalHandler().artist!.name),
      body: Center(
        child: Text('Details about ${GlobalHandler().artist!.name}'),
      ),
    );
  }
}