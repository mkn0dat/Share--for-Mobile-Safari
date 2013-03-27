#import <Twitter/TWTweetComposeViewController.h>

@interface AddressView : NSObject
{
    UILabel *_titleTextView;
}
- (UILabel *)titleTextView;
@end

%hook AddressView

%new(v@:@)
- (UILabel *)titleTextView
{
	return MSHookIvar<UILabel *>(self, "_titleTextView");
}
%end

@interface BrowserController : NSObject
{
    AddressView *_addressView;
}
+ (id)sharedBrowserController;
- (AddressView *)addressView;
@end

%hook BrowserController

%new(v@:@)
- (AddressView *)addressView
{
	return MSHookIvar<AddressView *>(self, "_addressView");
}
%end


@interface BrowserTweetViewController : TWTweetComposeViewController
- (void)viewDidAppear:(BOOL)arg1;
@end

%hook BrowserTweetViewController

- (id)init
{
    self = %orig;
    
    NSString *path = @"/var/mobile/Library/Preferences/com.mkn0dat.shareforsafari.plist";
	NSMutableDictionary *settingsDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	BOOL addTitle = [[settingsDictionary objectForKey:@"addTitle"] boolValue];
    if (addTitle){
        BrowserController *browserController = [%c(BrowserController) sharedBrowserController];
        AddressView *addressView = [browserController addressView];
        UILabel *label = [addressView titleTextView];
        [self setInitialText:[NSString stringWithFormat:@"%@",label.text]];
    }
    return self;
}

%end