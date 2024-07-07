import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String _getImagePath(String artistName) {
    switch (artistName.toLowerCase()) {
      case "aphaca":
        return 'images/Aphaca.jpg';
      case "storebjerg":
        return 'images/Storebjerg.png';
      case "aysay":
        return 'images/Aysay.jpg';
      case "døtre":
        return 'images/Døtre.png';
      case "elsked":
        return 'images/Elsked.jpg';
      case "iiris":
        return 'images/Iiris.png';
      case "pradanøia":
        return 'assets/images/PRADANØIE_COVER.jpg';
      case "tigeroak":
        return 'images/Tigeroak.png';
      default:
        return 'assets/images/BilledeKommerSnart.jpg';
    }
  }

  String _getFormattedTime(DateTime artistTime) {
    // Extract weekday from DateTime object
    String convertedTime = DateFormat('EEEE @ HH:mm', 'da_DK').format(artistTime);

    // Capitalize the first letter
    convertedTime = convertedTime.substring(0, 1).toUpperCase() + convertedTime.substring(1);
    
    // Return the first three letters of the weekday
    return convertedTime;

    /*
    switch (weekday) {
      case 1:
        return "Man";
      case 2:
        return "Tir";
      case 3:
        return "Ons";
      case 4:
        return "Tor";
      case 5:
        return "Fre";
      case 6:
        return "Lør";
      case 7:
        return "Søn";
      default:
        return "Fejl";
    }

*/

  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(imagePath);
    return ListTile(
      leading: image,
      title: Text(widget.artist.name),
      subtitle: Text(
          formattedTime),
      trailing: IconButton(
        icon: Icon(widget.favorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () => setState(() {
          widget.favorite = !widget.favorite;
        })
      ),
    );
  }
}

class Artist {
  final String name;
  final DateTime time;
  Artist({required this.name, required this.time});
}