import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability

    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
    // try {
    //   // let mainWin: window.Window = windowStage.getMainWindowSync();
    //   // mainWin.setWindowLayoutFullScreen(true).then(() => {
    //   //   console.info('已开启全屏');
    //   // });
    //   // mainWin.setSpecificSystemBarEnabled('status', false).then(() => {
    //   //   console.info('Succeeded in setting the status bar to be invisible.');
    //   // }).catch((err: BusinessError) => {
    //   //   console.error(`Failed to set the status bar to be invisible. Code is ${err.code}, message is ${err.message}`);
    //   // });
    //   // ✅ 使用 Promise 而不是 callback
    //   // const systemBarProps: window.SystemBarProperties = {
    //   //   statusBarColor: '#00000000',        // 状态栏透明
    //   //   navigationBarColor: '#00000000',    // 导航栏透明
    //   //   navigationBarContentColor: '#ffffff'
    //   // };

    //   // mainWin.setWindowSystemBarProperties(systemBarProps)
    //   //   .then(() => {
    //   //     console.info('成功设置系统栏属性');
    //   //   })
    //   //   .catch((err: BusinessError) => {
    //   //     console.error(`设置失败: ${err.code}, ${err.message}`);
    //   //   });

    // } catch (err) {
    //   console.info('开启全屏失败');
    // }

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}