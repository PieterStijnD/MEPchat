// adb shell am start -W -a android.intent.action.VIEW -d /login com.example.new_base
//
// adb shell am start -a android.intent.action.VIEW -d "example://mepchat" com.example.new_base
//
//
//
//
// adb shell am start \
// -W -a android.intent.action.VIEW \
// -d "https://new_base.example.com" \
// com.example.new_base


adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "http://localhost:8081/" com.example.new_base



adb shell am start -W -a android.intent.action.VIEW -d "http://localhost:8081/login" com.example.new_base