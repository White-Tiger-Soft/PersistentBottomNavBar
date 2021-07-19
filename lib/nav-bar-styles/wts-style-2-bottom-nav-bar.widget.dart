part of persistent_bottom_nav_bar;

class BottomNavStyleWTS2 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  BottomNavStyleWTS2({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return this.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : AnimatedContainer(
            width: 86.0,
            height: height! / 1.0,
            duration:
                this.navBarEssentials!.itemAnimationProperties?.duration ??
                    Duration(milliseconds: 1000),
            curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                Curves.ease,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration:
                  this.navBarEssentials!.itemAnimationProperties?.duration ??
                      Duration(milliseconds: 1000),
              curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              alignment: Alignment.center,
              height: height / 1.0,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0, top: 6.0),
                        child: SizedBox(
                          height: item.iconSize,
                          width: item.iconSize,
                          child: isSelected
                              ? item.icon
                              : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                      item.title == null
                          ? SizedBox.shrink()
                          : Material(
                              type: MaterialType.transparency,
                              child: DefaultTextStyle.merge(
                                style: item.textStyle != null
                                    ? item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorSecondary == null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary)
                                            : item.inactiveColorPrimary)
                                    : TextStyle(
                                        color: isSelected
                                            ? (item.activeColorSecondary == null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary)
                                            : item.inactiveColorPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.0),
                                child: Container(
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    item.title!,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  if ((item.notificationCount ?? 0) > 0)
                    Positioned(
                      right: 26,
                      top: 2,
                      child: _buildNotificationIcon(item.notificationCount!),
                    ),
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Color selectedItemActiveColor = this
        .navBarEssentials!
        .items![this.navBarEssentials!.selectedIndex!]
        .activeColorPrimary;
    double itemWidth = ((MediaQuery.of(context).size.width -
            ((this.navBarEssentials!.padding?.left ??
                    MediaQuery.of(context).size.width * 0.05) +
                (this.navBarEssentials!.padding?.right ??
                    MediaQuery.of(context).size.width * 0.05))) /
        this.navBarEssentials!.items!.length);
    return Container(
      width: double.infinity,
      height: this.navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          top: this.navBarEssentials!.padding?.top ?? 0.0,
          left: this.navBarEssentials!.padding?.left ??
              MediaQuery.of(context).size.width * 0.05,
          right: this.navBarEssentials!.padding?.right ??
              MediaQuery.of(context).size.width * 0.05,
          bottom: this.navBarEssentials!.padding?.bottom ??
              this.navBarEssentials!.navBarHeight! * 0.1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration:
                    this.navBarEssentials!.itemAnimationProperties?.duration ??
                        Duration(milliseconds: 300),
                curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                    Curves.ease,
                color: Colors.transparent,
                width: (this.navBarEssentials!.selectedIndex == 0
                        ? MediaQuery.of(context).size.width * 0.0
                        : itemWidth * this.navBarEssentials!.selectedIndex!) +
                    (itemWidth - 86) / 2,
                height: 2.0,
              ),
              Flexible(
                child: AnimatedContainer(
                  duration: this
                          .navBarEssentials!
                          .itemAnimationProperties
                          ?.duration ??
                      Duration(milliseconds: 300),
                  curve:
                      this.navBarEssentials!.itemAnimationProperties?.curve ??
                          Curves.ease,
                  width: 86,
                  height: 2.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedItemActiveColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this.navBarEssentials!.items!.map((item) {
                  int index = this.navBarEssentials!.items!.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (this.navBarEssentials!.items![index].onPressed !=
                            null) {
                          this.navBarEssentials!.items![index].onPressed!(this
                              .navBarEssentials!
                              .selectedScreenBuildContext);
                        } else {
                          this.navBarEssentials!.onItemSelected!(index);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            this.navBarEssentials!.selectedIndex == index,
                            this.navBarEssentials!.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(int count) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      decoration: BoxDecoration(
        color: Color(0xFFEB4646),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: TextStyle(fontSize: 11, color: Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
