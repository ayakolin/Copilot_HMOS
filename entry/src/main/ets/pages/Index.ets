import { webview } from '@kit.ArkWeb';
@Entry
@Component
struct Index {
  @State color_bg: string = '#000000'
  controller: webview.WebviewController = new webview.WebviewController();
  build() {
    Column() {
      Web({src: 'https://copilot.microsoft.com',controller: this.controller})
      . javaScriptAccess(true)
      . domStorageAccess(true)
      . darkMode(WebDarkMode.Auto)
      . expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_bg_color'))
  }
  }