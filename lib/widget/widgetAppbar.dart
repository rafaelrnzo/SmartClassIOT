import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/screens/profile/mainProfile.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppbar(context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: secondary,
    elevation: 0,
    title: ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearColor().createShader(bounds);
      },
      child: Text(
        'SmartClass',
        style: GoogleFonts.chakraPetch(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: bgWhite,
          child: IconButton(
            icon: const Icon(
              Icons.person_rounded,
              color: primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ),
      ),
    ],
  );
}


AppBar accesAppbar() {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
        'Accesibility',
        style: bold24Prim()
      ),
    
  );
}
AppBar kwhAppbar() {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
        'KwH Monitoring',
        style: bold20Prim()
      ),
    
  );
}

AppBar roomAppbar() {
  return AppBar(
    leading: const BackButton(color: primary),
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
        'Room 1',
        style: bold20Prim()
      ),
    
  );
}
AppBar audioAppbar() {
  return AppBar(
    leading: const BackButton(color: primary),
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
        'Audio',
        style: bold20Prim()
      ),
    
  );
}
AppBar acAppbar() {
  return AppBar(
    leading: BackButton(color: primary),
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
        'Panasonic AC',
        style: bold20Prim()
      ),
    
  );
}

