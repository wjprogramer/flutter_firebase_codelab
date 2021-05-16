# **設定macOS**

 macOS的配置步驟幾乎與iOS相同。我們將重新使用上述iOS步驟中的配置文件**`GoogleService-Info.plist`** 。

1. 運行命令`open macos/Runner.xcworkspace`打開Xcode。

**提示**：閱讀有關[信息屬性列表文件](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html)以獲取有關Xcode屬性列表的更多信息。

1. 將`GoogleService-Info.plist`文件拖到**Runner**子文件夾中。這是在上面的“**配置iOS”**步驟中創建的。 
2. 在`macos/Runner/DebugProfile.entitlements`文件中，添加`com.apple.security.network.client`權利，並將其設置為`true` 。 
3. 在`macos/Runner/Release.entitlements`文件中，還添加`com.apple.security.network.client`權利，並將其設置為`true` 。 
4. 由於現在不需要Xcode，因此請隨時關閉Xcode。

您已經完成了針對macOS的Flutter應用的配置。有關更多詳細信息，請參見[FlutterFire macOS安裝文檔](https://firebase.flutter.dev/docs/installation/macos/)以及[Flutter](https://flutter.dev/desktop)的[桌面支持](https://flutter.dev/desktop)頁面。 

