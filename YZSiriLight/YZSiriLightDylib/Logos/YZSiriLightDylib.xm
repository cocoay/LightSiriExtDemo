// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import <LightKit/LightKit.h>
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>


@interface CustomViewController

@property (nonatomic, copy) NSString* newProperty;

+ (void)classMethod;

- (NSString*)getMyName;

- (void)newMethod:(NSString*) output;

@end

%hook CustomViewController

+ (void)classMethod
{
	%log;

	%orig;
}

%new
-(void)newMethod:(NSString*) output{
    NSLog(@"This is a new method : %@", output);
}

%new
- (id)newProperty {
    return objc_getAssociatedObject(self, @selector(newProperty));
}

%new
- (void)setNewProperty:(id)value {
    objc_setAssociatedObject(self, @selector(newProperty), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)getMyName
{
	%log;
    
    NSString* password = MSHookIvar<NSString*>(self,"_password");
    
    NSLog(@"password:%@", password);
    
    [%c(CustomViewController) classMethod];
    
    [self newMethod:@"output"];
    
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty : %@", self.newProperty);

	return %orig();
}

%end



@interface ViewController: UIViewController <INUIAddVoiceShortcutViewControllerDelegate> 

- (void)setupSiri;

@end


%hook ViewController

- (void)viewDidLoad {
    %log;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FUCK" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    %orig;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    %log;
    %orig;
    [self setupSiri];
}


%new
- (void)setupSiri {

//    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.zougefan.FuckTest.Fuck"];
//    activity.eligibleForSearch = YES;
//    activity.title = @"哈哈";
//    activity.eligibleForPrediction = YES;
//    activity.suggestedInvocationPhrase = @"好的";
//    self.userActivity = activity;
    
    LightIntent *intent = [[LightIntent alloc] init];
    if (!intent) {
        return;
    }
    INShortcut *shortcut = [[INShortcut alloc] initWithIntent:intent];
    if (!shortcut) {
        return;
    }
    INUIAddVoiceShortcutViewController *nextVC = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortcut];
    nextVC.modalPresentationStyle = UIModalPresentationFormSheet;
    nextVC.delegate = self;
    [self presentViewController:nextVC animated:YES completion:nil];
}

%new
- (void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

%end
