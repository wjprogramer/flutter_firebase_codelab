## [9. Bonus step: Practice what you've learned](https://firebase.google.com/codelabs/firebase-get-to-know-flutter?continue=https%3A%2F%2Ffirebase.google.com%2Flearn%2Fpathways%2Ffirebase-flutter%23codelab-https%3A%2F%2Ffirebase.google.com%2Fcodelabs%2Ffirebase-get-to-know-flutter#8)

## **Record an attendee's RSVP status**

Right now, your app just allows people to start chatting if they're  interested in the event. Also, the only way you know if someone's coming is if they post it in the chat. Let's get organized and let people know how many people are coming.

You are going to add a couple of new capabilities to the application  state. The first is the ability for a logged in user to nominate if they are attending or not. The second capability is a counter of how many  people are actually attending.

In `lib/main.dart`, add the following to the accessors section to enable the UI code to interact with this state:

### [lib/main.dart](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart#L190)

```
int _attendees = 0;
int get attendees => _attendees;

Attending _attending = Attending.unknown;
StreamSubscription<DocumentSnapshot>? _attendingSubscription;
Attending get attending => _attending;
set attending(Attending attending) {
  final userDoc = FirebaseFirestore.instance
      .collection('attendees')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  if (attending == Attending.yes) {
    userDoc.set({'attending': true});
  } else {
    userDoc.set({'attending': false});
  }
}
```

Update `ApplicationState`'s `init` method as follows:

### [lib/main.dart](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart#L119)

```
  Future<void> init() async {
    await Firebase.initializeApp();

    // Add from here
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });
    // To here

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          snapshot.docs.forEach((document) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'],
                message: document.data()['text'],
              ),
            );
          });
          notifyListeners();
        });
        // Add from here
        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data()!['attending']) {
              _attending = Attending.yes;
            } else {
              _attending = Attending.no;
            }
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
        // to here
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel(); // new
      }
      notifyListeners();
    });
  }
```

The above adds an always subscribed query to find out the number of  attendees, and a second query that is only active while a user is logged in to find out if the user is attending. Next, add the following  enumeration after the `GuestBookMessage` declaration:

### [lib/main.dart](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart#L279)

```
enum Attending { yes, no, unknown }
```

You are now going to define a new widget that acts like radio buttons of old. It starts off in an indeterminate state, with neither yes nor  no selected, but once the user selects whether they are attending or  not, then you show that option highlighted with a filled button, and the other option receding with a flat rendering.

### [lib/main.dart](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart#L355)

```
class YesNoSelection extends StatelessWidget {
  const YesNoSelection({required this.state, required this.onSelection});
  final Attending state;
  final void Function(Attending selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Attending.yes:
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Attending.yes),
                child: Text('YES'),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: () => onSelection(Attending.no),
                child: Text('NO'),
              ),
            ],
          ),
        );
      case Attending.no:
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Attending.yes),
                child: Text('YES'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Attending.no),
                child: Text('NO'),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Attending.yes),
                child: Text('YES'),
              ),
              SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Attending.no),
                child: Text('NO'),
              ),
            ],
          ),
        );
    }
  }
}
```

Next, you need to update `HomePage`'s build method to take advantage of `YesNoSelection`, enabling a logged in user to nominate if they are attending. You will also display the number of attendees for this event.

### [lib/main.dart](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart#L79)

```
Consumer<ApplicationState>(
  builder: (context, appState, _) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Add from here
      if (appState.attendees >= 2)
        Paragraph('${appState.attendees} people going')
      else if (appState.attendees == 1)
        Paragraph('1 person going')
      else
        Paragraph('No one going'),
      // To here.
      if (appState.loginState == ApplicationLoginState.loggedIn) ...[
        // Add from here
        YesNoSelection(
          state: appState.attending,
          onSelection: (attending) => appState.attending = attending,
        ),
        // To here.
        Header('Discussion'),
        GuestBook(
          addMessage: (String message) =>
              appState.addMessageToGuestBook(message),
          messages: appState.guestBookMessages,
        ),
      ],
    ],
  ),
),
```

## **Add rules**

Because you already have some rules set up, the new data that you're  adding with the buttons is going to be rejected. You'll need to update  the rules to allow adding to the `attendees` collection.

For the `attendees` collection, since you used the Authentication UID as the document name, you can grab it and verify that the submitter's `uid` is the same as the document they are writing. You'll allow everyone to  read the attendees list (since there is no private data there), but only the creator should be able to update it.

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // ... //
    match /attendees/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

## **Add validation rules**

Add data validation to make sure that all of the expected fields are present in the document:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // ... //
    match /attendees/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId
          && "attending" in request.resource.data;

    }
  }
}
```

*(Optional)* You can now view the results of clicking the buttons. Go to your Cloud Firestore dashboard in the Firebase console.