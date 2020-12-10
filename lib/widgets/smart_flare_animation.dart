import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:page_transition/page_transition.dart';
import '../pages/create/new_task.dart';
import '../pages/create/check_list.dart';
import '../pages/create/new_note.dart';
import '../pages/create/new_task.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import '../backend/singleton.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation>{
  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  AnimationToPlay _lastPlayedAnimation;

  // Flare animation controls
  final FlareControls animationControls = FlareControls();

  bool isOpen = false;

  bool hide = false;

  int _selectedIndex = 0;

  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
          onTapUp: (tapInfo) {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapInfo.globalPosition);

            var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;

            var leftSideTouched = localTouchPosition.dx < AnimationWidth / 3 * 1.2;

            var rightSideTouched =
                localTouchPosition.dx > (AnimationWidth / 3) * 2;

            var middleTouched = !leftSideTouched && !rightSideTouched;

            // Call our animation in our conditional checks
            if (leftSideTouched && topHalfTouched && isOpen) {
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckList())
              );
            } else if (middleTouched && topHalfTouched && isOpen) {
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewNote())
              );
            } else if (rightSideTouched && topHalfTouched && isOpen) {
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
              _pickImage();
            } else {
              if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else if (middleTouched) {
                _setAnimationToPlay(AnimationToPlay.Activate);
              }

              isOpen = !isOpen;
            }
          },
          child: FlareActor('asset/button-animation.flr',
              controller: animationControls, animation: 'deactivate'),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    _lastPlayedAnimation = animation;
  }

  Future<void> _pickImage() async {
    List<Asset> resultList = List<Asset>();
    // String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        //enableCamera: true,
        selectedAssets: Provider.of<Singleton>(context, listen: false).assets,
        cupertinoOptions: CupertinoOptions(
          backgroundColor: "#ffffff",
          selectionFillColor: "#000000",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#000000",
          // actionBarTitle: "Example App",
          lightStatusBar: false,
          statusBarColor: "#000000",
          actionBarTitleColor: "#ffffff",
          // allViewTitle: "All Photos",
          // startInAllView: true,
          useDetailsView: false,
          // selectCircleStrokeColor: "#000000",
          selectionLimitReachedText: "Вы не можете прикрепить более 6 фотографий",
          // textOnNothingSelected: "",
          // backButtonDrawable: "",
          // okButtonDrawable: "",
          // autoCloseOnSelectionLimit: true,
        ),
      );
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (resultList.length != 0) {
        Provider.of<Singleton>(context, listen: false).assets = resultList;
      }
      // _error = error;
    });
  }
}