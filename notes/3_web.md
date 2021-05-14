# 設定 Web

1. 在[Firebase控制台中](https://console.firebase.google.com)，在左側導航欄中選擇“**項目概述**”，然後單擊“**將Firebase添加到您的應用入門”**下的“ **Web”**按鈕。

**注意**：如果您已經添加了一個應用程序（例如，前面幾節中的iOS應用程序和/或Android應用程序），請點擊**添加應用程序**。 

![25b14deff9e589ce.png](https://firebase.google.com/codelabs/firebase-get-to-know-flutter/img/25b14deff9e589ce.png)

1. 為該應用程序起一個暱稱，然後單擊“**註冊應用程序”**按鈕。由於本教程僅在本地運行，因此我們將關閉Firebase Hosting。請在此處隨意閱讀有關Firebase Hosting的更多信息。 ![9c697cc1b309c806.png](https://firebase.google.com/codelabs/firebase-get-to-know-flutter/img/9c697cc1b309c806.png)
2. 如下編輯`web/index.html`文件的主體部分。請確保添加上一步中的`firebaseConfig`數據。

###  [web / index.html](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_04/web/index.html)

```html
<body>
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('flutter-first-frame', function () {
        navigator.serviceWorker.register('flutter_service_worker.js');
      });
    }
  </script>

  <!-- Add from here -->
  <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-firestore.js"></script>
  <script>
    // Your web app's Firebase configuration
    var firebaseConfig = {
      // Replace this with your firebaseConfig
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  </script>
  <!-- to here. -->

  <script src="main.dart.js" type="application/javascript"></script>
</body>
```

您已經完成了針對Web的Flutter應用的配置。有關更多詳細信息，請參見[FlutterFire Web安裝文檔](https://firebase.flutter.dev/docs/installation/web/)。

