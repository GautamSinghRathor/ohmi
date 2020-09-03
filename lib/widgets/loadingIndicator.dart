import 'package:flutter/material.dart';
import 'package:ohmi/constant.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              // backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorTheme.secondColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
