import '../../utils/libraries/app_libraries.dart';

class DoneButton extends StatelessWidget {
  final String text;
  const DoneButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 63,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xff808BFF),
      ),
      child: Center(child: Text(text)),
    );
  }
}
