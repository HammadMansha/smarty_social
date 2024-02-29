import '../utils/libraries/app_libraries.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<CustomBottomNavBarItem> items;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final bool isSelected = items.indexOf(item) == currentIndex;
          return InkWell(
            onTap: () => onTap(items.indexOf(item)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon is IconData)
                  Icon(
                    item.icon as IconData,
                    color: isSelected ? Colors.blue : Colors.grey,
                  )
                else if (item.icon is String)
                  Image.asset(
                    item.icon as String,
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                SizedBox(height: 4),
                Text(
                  item.title,
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavBarItem {
  final dynamic icon;
  final String title;

  CustomBottomNavBarItem({
    required this.icon,
    required this.title,
  });
}
