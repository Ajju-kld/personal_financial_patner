# personal_financial_tracker
Its a personal financial tracker used to track you daily expense and store it in google sheet

API 📧
google sheet api

# How to use this project
# step 1 :-
Activate googlesheet api from your account in google.cloud.com and create service account, download key and copy the service  account mail that 
is generated in your service account and share your googlesheet with service account mail
# step 2:-
Clone this repo to your pc and connect your phone with developer mode on (works only with android for live testing)
and  copy your credential which is present in the key file that you downloaded earlier to the commented area in GoogleSheetApi.dart
# given below sample

```dart
class GoogleSheetApi {
  static const _credential = r'''
{

/*paste your credential*/

  }''';
```


Also copy spread id as shown in this screenshot



![Screenshot from 2022-05-02 13-04-17](https://user-images.githubusercontent.com/67229095/166201350-d91946af-b894-43b6-9a89-bf138f27cf56.png)

copy this id and assign to variable shown below in GoogleSheetApi.dart
```dart 
 static final _spreadsheetid = 'paste the id here';

```


# step 3:- 
```terminal
flutter run --no-sound-null-safety
```
