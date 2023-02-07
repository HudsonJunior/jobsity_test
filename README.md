
All mandatory features have been done.

## Compiling the app
- The Flutter's version used to build this app was v3.7.0.
- There is not any flavors or specific entry point file.
- You can get the dependencies using `flutter pub get`.
- To run this applicationg in the debug mode you can use `flutter run`.
- To run this applicationg in the release mode you can use `flutter run --release`.
- To generate the APK file you can use `flutter build apk --release`.

## Some considerations
- I tried to follow some clean architecture patterns, such as using the data, domain and view layers. Also I've followed some S.O.L.I.D principles.
- I tried to write all the code following clean code best practices.
- I used Slivers and other performance tools to create an efficient app.
- I used BLoC as my State Management Library.
- I used DIO as my service provider.
- I used get_it as a service locator to inject dependencies.

## Things I could do (But did not have time to)
- Created unit tests.
- Improved some UI.
- Used some animations to make the UI look better.
- Paginations on the list TV shows page

## Others considerations about the process and the project.
- I used Slivers. Sliver is way more performantic and complex than common ScrollView.
- Hero is a way to do some transitions animated that comes default in the Flutter sdk.
- Abstracting classes is useful to not attach the implemetation to the class, being able to change the implemetation anytime without affecting the whole code.
- I didn't separate some widgets into specific files because I think this could affect the readability of the project. Sometime when the widgets are small and only used in one page, it's better to keep it in the same file.
- I could write unit, widget and integrations tests. That is something that I am really used to do. For this project, I didn't have the time to create the tests due to other personal projects I have to deal during my day.
- The time I spent on the challege was about 10 hours. I do not think a project I did on only 10 hours reflects on all the experience I have. When working in a project, focused 8 hours each day, definitely thw work I do is way more better than this.
- I would like to have a more technical interview, where I could answer any questions about the Flutter framework. I know how the framework works in the deep and I am sure I have enough knowledge to be considered a mid-level to Senior and not just a Junior.
- Please understand that I have other work to do in my day, so I tried to focus on this challenge the best I could, but it's difficult when you have to deal with other responsibilities simultaneously. That is why I prefer technical interviews to talk about my experience and not just create a small project to show my abilities, I don't think this challenge tells everything you need to know about my experience. I can show all my theoretical and practical knowledge when talking directly to the evaluator. When creating only a small project to evaluate my experience, you don't see how I code and why I made some decisions.

Please feel free to reach out to me anytime.
