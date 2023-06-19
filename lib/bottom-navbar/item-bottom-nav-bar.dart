import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app-bottom-navigation-bar.dart';

class AppTabItem extends StatefulWidget {
  final String? title;
  final bool selected;
  final String? image;
  final TextStyle textStyle;
  final Function callbackFunction;
  final Color tabIconColor;
  final double? tabIconSize;
  final Widget? badge;

  const AppTabItem({
    super.key,
    required this.title,
    required this.selected,
    required this.image,
    required this.textStyle,
    required this.tabIconColor,
    required this.callbackFunction,
    this.tabIconSize = 24,
    this.badge,
  });

  @override
  _AppTabItemState createState() => _AppTabItemState();
}

class _AppTabItemState extends State<AppTabItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(AppTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: ANIM_DURATION),
              alignment: Alignment(0, textYAlign),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.selected
                    ? Text(
                        widget.title!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(0, 163, 228, 1),
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      )
                    : const Text(''),
              ),
            ),
          ),
          InkWell(
            onTap: () => widget.callbackFunction(),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: ANIM_DURATION),
                curve: Curves.easeIn,
                alignment: Alignment(0, iconYAlign),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: ANIM_DURATION),
                  opacity: iconAlpha,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                        onTap: () => widget.callbackFunction(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(widget.image.toString(),
                                height: 20,
                                width: 20,
                                color: const Color.fromRGBO(211, 211, 211, 1)),
                            const SizedBox(height: 5),
                            Text(widget.title.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(211, 211, 211, 1),
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                      widget.badge != null
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: widget.badge!,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
