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

7. 繼續在Firebase中，按照說明下載配置文件**`google-services.json`** 。

8. 轉到您的Flutter應用程序目錄，然後將`google-services.json`文件（您剛剛下載的文件）移動到`android/app`目錄中。

9. 返回Firebase控制台，跳過其餘步驟，然後返回Firebase控制台的主頁。

10. 編輯您的`android/build.gradle`以添加`google-services`插件依賴項：







