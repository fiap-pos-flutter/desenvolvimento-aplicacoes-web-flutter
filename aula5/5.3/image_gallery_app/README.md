## Test execution
[flutter test test/unit_test.dart](https://docs.flutter.dev/testing/integration-tests#create-a-new-app-to-test)

```shell
export PATH="$PATH:/Users/felipeaugusto/Development/projects/fiap-pos-flutter/desenvolvimento-aplicacoes-web-flutter/aula5/5.3/image_gallery_app/chromedriver/mac_arm-128.0.6613.84/chromedriver-mac-arm64"
```

- Create a file called 'script.sh'. Inside of this file
```yaml
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d chrome
```

- In the terminal
`chmod +x ./script.sh`
