import 'package:flutter/material.dart';
//import 'package:googleapis/chat/v1.dart';

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
  late String weekday;

  @override
  void initState() {
    super.initState();
    imagePath = _getImagePath(widget.artist.name);
    weekday = _getWeekday(widget.artist.time.weekday);
  }

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
        return 'assets/images/BilledeKommerSnart.png';
    }
  }

  String _getWeekday(int weekday) {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image(image: AssetImage(imagePath));
    return ListTile(
      leading: image,
      title: Text(widget.artist.name),
      subtitle: Text(
          "$weekday @ ${widget.artist.time.hour.toString().padLeft(2, '0')}:${widget.artist.time.minute.toString().padLeft(2, '0')}"),
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