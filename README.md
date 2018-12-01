# flutter_smartwatch
Flutterでスマートウォッチアプリを構築します。

# ビルドするには
1. Flutterの開発環境を構築する。
    1. Flutterのインストール        
        - https://flutter.io/get-started/install/
    1. IDE・エディターの設定
        - https://flutter.io/get-started/editor/#androidstudio
    1. プロジェクトの生成・アプリの起動・ホットリロードの確認
        - https://flutter.io/get-started/test-drive/#androidstudio
1. <app dir>/android/key.propertiesを追加する。詳細は[公式ドキュメント](https://flutter.io/docs/deployment/android)を参照。
    1. 任意のディレクトリで以下のコードを実行する。

        ```
        keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
        ```
    1. <app dir>/android/key.propertiesを追加する。ファイルには、以下の内容を記載する。

        ```
        storePassword=<password from previous step>
        keyPassword=<password from previous step>
        keyAlias=key
        storeFile=<location of the key store file, e.g. /Users/<user name>/key.jks>
        ```
1. プロジェクトディレクトリで以下のコードを実行する。

    ```
    flutter build apk
    ```
1. build\app\outputs\apk\release\app-release.apkができているか確認する。