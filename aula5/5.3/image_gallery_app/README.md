## Test execution
[flutter test test/unit_test.dart](https://docs.flutter.dev/testing/integration-tests#create-a-new-app-to-test)

- Create a file called 'script.sh'. Inside of this file
```yaml
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d chrome
```

- In the terminal
`chmod +x ./script.sh`
