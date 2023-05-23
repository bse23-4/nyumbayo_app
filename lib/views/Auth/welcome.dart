import '/exports/exports.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of( context);
    var height = mediaQuery.size.height;
    // var brightness = mediaQuery.platformBrightness;
    // final isDarkMode  = brightness == Brightness.dark;
    return Scaffold(
      //backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Container( 
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          Column( 
            children:  [
                // Text(tWelcomeTitle, style: Theme.of(context).textTheme.displaySmall,),
                // Text(tWelcomeSubTitle, textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
          //  Image(image: const AssetImage(tWelcomeScreenImage), height: height * 0.5,),
          Row(
             children :  [
             Expanded(
              child:  OutlinedButton(
                onPressed: (){}, 
                child: const Text("Login")
              ),
              ),
             const SizedBox(width:10.0),
             Expanded(
              child:  ElevatedButton(
                onPressed: () {},
                child: const Text("Sign Up")
                ),
                ),
            ]
          ),
        ],
        ),
      ),
    );
  }
}