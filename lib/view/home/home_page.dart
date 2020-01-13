import 'package:driver_app/base/base.dart';
import 'package:driver_app/view/home/cancel/cancel_page.dart';
import 'package:driver_app/view/home/home_provider.dart';
import 'package:driver_app/view/home/new/new_page.dart';
import 'package:driver_app/view/home/success/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'destination_model.dart';

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'New', Icons.fiber_new, Colors.blue),
  Destination(1, 'Success', Icons.done_outline, Colors.orange),
  Destination(2, 'Cancel', Icons.cancel, Colors.red),
];

class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver(this.onNavigation);

  final VoidCallback onNavigation;

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
}

class DestinationView extends StatefulWidget {
  final BuildContext homeContext;
  const DestinationView(this.homeContext,
      {Key key, this.destination, this.onNavigation})
      : super(key: key);

  final Destination destination;
  final VoidCallback onNavigation;

  @override
  _DestinationViewState createState() => _DestinationViewState(homeContext);
}

class _DestinationViewState extends State<DestinationView> {
  BuildContext homeContext;

  _DestinationViewState(this.homeContext);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (widget.destination.index == 0) {
              return NewPage(homeContext);
            } else if (widget.destination.index == 1) {
              return SuccessPage(homeContext);
            } else {
              return CancelPage(homeContext);
            }
          },
        );
      },
    );
  }
}

class HomePage extends PageProvideNode<HomeProvider> {

  @override
  Widget buildContent(BuildContext context) {
    return _HomeContentPage(mProvider);
  }
}

class _HomeContentPage extends StatefulWidget{

  final HomeProvider provider;
  _HomeContentPage(this.provider);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<_HomeContentPage>
    with TickerProviderStateMixin<_HomeContentPage> {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  HomeProvider mProvider;

  @override
  void initState() {
    super.initState();

    mProvider = widget.provider;
    _faders =
        allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[mProvider.currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Scaffold(
            body: SafeArea(
              top: false,
              child: Stack(
                fit: StackFit.expand,
                children: allDestinations.map((Destination destination) {
                  final Widget view = FadeTransition(
                    opacity: _faders[destination.index]
                        .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                    child: KeyedSubtree(
                      key: _destinationKeys[destination.index],
                      child: DestinationView(
                        context,
                        destination: destination,
                        onNavigation: () {
                          _hide.forward();
                        },
                      ),
                    ),
                  );
                  if (destination.index == value.currentIndex) {
                    _faders[destination.index].forward();
                    return view;
                  } else {
                    _faders[destination.index].reverse();
                    if (_faders[destination.index].isAnimating) {
                      return IgnorePointer(child: view);
                    }
                    return Offstage(child: view);
                  }
                }).toList(),
              ),
            ),
            bottomNavigationBar: ClipRect(
              child: SizeTransition(
                sizeFactor: _hide,
                axisAlignment: -1.0,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  currentIndex: value.currentIndex,
                  onTap: (int index) {
                    value.currentIndex = index;
                  },
                  items: allDestinations.map((Destination destination) {
                    return BottomNavigationBarItem(
                        icon: Icon(destination.icon),
                        backgroundColor: destination.color,
                        title: Text(destination.title));
                  }).toList(),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
