import '/exports/exports.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  const NoDataWidget({super.key, this.text = "There's nothing here.."});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: SvgPicture.asset("assets/images/nothing.svg"),
        ),
        const Space(space: 0.03),
        Text(
          text,
          style: TextStyles(context)
              .getRegularStyle()
              .copyWith(fontSize: 20, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
