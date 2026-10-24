#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach/mach.h>

// Standoff2 Mod - 带悬浮窗菜单的dylib
// 语言: Objective-C++ (Logos语法)
// 编译: Theos make

static UIWindow *menuWindow = nil;
static BOOL menuVisible = NO;

// 创建悬浮球
void createFloatingButton() {
    menuWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
    menuWindow.windowLevel = UIWindowLevelAlert + 1;
    menuWindow.backgroundColor = [UIColor clearColor];
    menuWindow.hidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 60);
    btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:0.8];
    btn.layer.cornerRadius = 30;
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn setTitle:@"S" forState:UIControlStateNormal];
    [btn addTarget:nil action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [vc.view addSubview:btn];
    menuWindow.rootViewController = vc;
}

// 显示菜单
void showMenu() {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Standoff2 Mod" 
        message:@"选择功能" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"无后座: 开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"[Mod] 无后座已开启");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"快速换弹: 开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"[Mod] 快速换弹已开启");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"武器大小: 小" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"[Mod] 武器变小");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    UIViewController *topVC = menuWindow.rootViewController;
    [topVC presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor))
static void init() {
    NSLog(@"[StandoffMod] dylib已加载");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        createFloatingButton();
        NSLog(@"[StandoffMod] 悬浮窗已创建");
    });
}
