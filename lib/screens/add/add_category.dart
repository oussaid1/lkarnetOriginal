import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 340,
        width: 400,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Text(
                        'category',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      height: 45,
                      width: 240,
                      child: TextField(
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.none),
                          ),
                          hintText: 'shopping',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(Icons.category),
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Text(
                        'item-price',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          height: 45,
                          width: 120,
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(6.0),
                                borderSide: new BorderSide(),
                              ),
                              hintText: '00.00',
                              hintStyle: GoogleFonts.robotoSlab(),
                              contentPadding: EdgeInsets.only(top: 4),
                              // prefixIcon: Icon(Icons.qr_code),

                              filled: true,
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    child: TextButton(
                      child: Text('Cancel'),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.headline3,
                        minimumSize: Size(88, 36),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    child: TextButton(
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.headline3,
                        minimumSize: Size(88, 36),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        elevation: 0,
                        onSurface: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
