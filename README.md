# TagList
自定义标签显示控件，简单灵活易用，功能点如下：
1：可动态 添加/删除 一个或多个 标签
2：根据当前tag内容多少进行自动排列
3：支持自动换行及添加多个标签后的整体自动布局
4：可自定义tag文本字体大小、字体颜色及背景颜色
5：每项tag标签点击均可触发自定义事件

####效果图如下

####使用方法
```objc
#import "ViewController.h"
#import "ZLTagListView.h"

#define kMainScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kMainScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UITextFieldDelegate>
{
    IBOutlet UITextField *_textField;
    //创建ZLTagListView对象
    ZLTagListView *_tagListView;
}
@end

- (void)createTagListView
{
    //初始坐标
    _tagListView = [[ZLTagListView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 40, 10) tagTitles:@"Foo,Tag Label 1,Tag Label 2"];
    _tagListView.center = self.view.center;
    //自定义tag背景色
    _tagListView.tagBgColor = [UIColor colorWithRed:0.18 green:0.64 blue:0.37 alpha:1];
    //自定义tag标题颜色
    _tagListView.tagTitleColor = [UIColor whiteColor];
    //自定义tag字体大小
    _tagListView.tagFontSize = 15.0f;
    
    typeof(ViewController) *weakSelf = self;
    //实现点击方法
    [_tagListView setClickAction:^(NSString *title) {
        [weakSelf showAlertView:[NSString stringWithFormat:@"click %@", title]];
    }];
    
    [self.view addSubview:_tagListView];
}

```

####添加一个或者多个标签
```objc
- (IBAction)btnClick:(id)sender
{
    [_tagListView addTagTitle:@"new tag"];
}
```

####删除一个或者多个标签
```objc
- (IBAction)btnDelete:(id)sender
{
    [_tagListView deleteTagTitle:@"Foo"];
}
```
