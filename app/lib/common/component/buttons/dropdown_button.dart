import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class DropDownButton extends StatefulWidget {
  //currentItem이 null이면 선택하지 않은걸로 간주 => 지역선택
  //currentItem이 있으면 선택 => provider update
  final String? currentItem;
  final Function? onPressed;
  final List? dropDownList;

  DropDownButton({
    super.key, required this.dropDownList, this.onPressed, this.currentItem});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool isPressed = false;

  void onPressDropDown(){
    setState(() {
      isPressed = !isPressed;
    });
  }
  @override
  Widget build(BuildContext context) {
    final currentItem = widget.currentItem;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: (){
          if(widget.dropDownList != null){
            onPressDropDown();
          }
        },
        child: Container(
          width: 160,
          height: isPressed ? 140 : 50,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: GREY_BORDER)
          ),
          child: widget.dropDownList != null ?

          Row(
            children: [
              if (isPressed)
                Flexible(
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.dropDownList!.map(
                              (e) => SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: BLACK,
                                    splashFactory: NoSplash.splashFactory
                                ),
                                child: Text(e, style: Theme.of(context).textTheme.bodyMedium,),
                                onPressed: (){
                                  if(widget.onPressed != null){
                                    widget.onPressed!(e);
                                  }
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                },))).toList(),
                    ),
                  ),
                ) else Flexible(
                  fit: FlexFit.tight,
                  child: Center(
                      child: Text(currentItem != null ? currentItem : '선택'))),
                  Icon(Icons.arrow_drop_down_rounded)
            ],
          )

          : SizedBox.shrink(),
        ),
      ),
    );
  }
}