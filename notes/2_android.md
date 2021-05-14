# 設定 Android

![](images/setup_android_0.png)

![](images/setup_android_1.PNG)

1. 提供的重要值是**Android套件名稱**。當您執行以下兩個步驟時，您將獲得套件名稱：

   > **提示**：閱讀[設置應用程序ID](https://developer.android.com/studio/build/application-id.html)以獲取有關程序包和應用[程序ID](https://developer.android.com/studio/build/application-id.html)的更多信息。

2. 在您的Flutter應用目錄中，打開文件`android/app/src/main/AndroidManifest.xml` 。

3. 在`manifest`元素中，找到`package`屬性的字符串值。該值是Android套件的名稱（類似於`com.yourcompany.yourproject` ）。複製此值。

4. 在Firebase對話框中，將復制的程序包名稱粘貼到**Android套件名稱**字段中。

5. 您不需要此程式實驗室的**Debug簽名證書SHA-1** 。將此留空。

6. 點擊**註冊應用**。

7. 繼續在Firebase中，按照說明下載設定文件**`google-services.json`** 。

8. 轉到您的Flutter應用程序目錄，然後將`google-services.json`文件（您剛剛下載的文件）移動到`android/app`目錄中。

9. 返回Firebase控制台，跳過其餘步驟，然後返回Firebase控制台的主頁。

10. 編輯您的`android/build.gradle`以添加`google-services`插件相依套件：
     [android / build.gradle](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_04/android/build.gradle#L11)

    ```
    dependencies {
            classpath 'com.android.tools.build:gradle:4.1.0'
            classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
            classpath 'com.google.gms:google-services:4.3.5'  // new
    }
    ```

11. 編輯您的`android/app/build.gradle`以啟用`google-services`插件：

    [android / app / build.gradle](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_04/android/app/build.gradle#L27)

    ```
    apply plugin: 'com.android.application'
    apply plugin: 'kotlin-android'
    apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
    apply plugin: 'com.google.gms.google-services'  // new
    ```

12.  Firebase需要啟用Multidex，並且一種實現方法是將受支持的最低SDK設置為21或更高。編輯您的`android/app/build.gradle`以更新`minSdkVersion` ：

    [android / app / build.gradle](https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_04/android/app/build.gradle#L43)

    ```defaultConfig {
    defaultConfig {
    	applicationId "com.example.gtk_flutter"
        minSdkVersion 21  // Updated
        targetSdkVersion 30
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }



您已經完成了針對Android的Flutter應用的配置。有關更多詳細信息，請參閱[FlutterFire Android安裝文檔](https://firebase.flutter.dev/docs/installation/android/)。



