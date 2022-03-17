import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayatri/Constants/constants.dart';
import 'package:sahayatri/Services/map_services/location_name.dart';

class SearchLocation extends StatelessWidget {
  SearchLocation({
    Key? key,
    required this.onTapOrigin,
    required this.onTapDestination,
  }) : super(key: key);
  final Function() onTapOrigin;
  final Function() onTapDestination;

  @override
  Widget build(BuildContext context) {
    TextEditingController origin = new TextEditingController();
    TextEditingController destination = new TextEditingController();
    return Consumer<LocationName>(builder: (context, place, child) {
      origin.text = place.originName;
      destination.text = place.destinationName;
      return Container(
        height: 142.0,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick up the location',
                style: kTextStyle,
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Origin',
                    style: kSmallTextStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Destination',
                    style: kSmallTextStyle,
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35.0,
                    width: 235.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                      child: TextFormField(
                        enabled: false,
                        controller: origin,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Origin',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 35.0,
                    width: 235.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Color.fromARGB(255, 214, 214, 214),
                      ),
                      child: TextFormField(
                        enabled: false,
                        controller: destination,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Destination',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 30.0,
                      child: IconButton(
                          onPressed: onTapOrigin,
                          icon: Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.blue.shade900,
                          ))),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      height: 30.0,
                      child: IconButton(
                          onPressed: onTapDestination,
                          icon: Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.amber,
                          ))),
                ],
              ),
            ],
          )
        ]),
      );
    });
  }
}
