#import "AppDelegate+FirebaseDynamicLinksPlugin.h"
#import "FirebaseDynamicLinksPlugin.h"
#import <objc/runtime.h>

@implementation AppDelegate (FirebaseDynamicLinksPlugin)

+ (void)load {
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(application:openURL:options:)];
        [self swizzleMethod:@selector(application:continueUserActivity:restorationHandler:)];
    });
}

+ (void)swizzleMethod:(SEL)originalSelector {
    Class class = [self class];
    NSString *selectorString = NSStringFromSelector(originalSelector);
    SEL newSelector = NSSelectorFromString([@"swizzled_" stringByAppendingString:selectorString]);
    SEL defaultSelector = NSSelectorFromString([@"default_" stringByAppendingString:selectorString]);
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    Method noopMethod = class_getInstanceMethod(class, defaultSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod ?: noopMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

- (BOOL)default_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    return FALSE;
}

- (BOOL)swizzled_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    // always call original method implementation first
    BOOL handled = [self swizzled_application:app openURL:url options:options];
    FirebaseDynamicLinksPlugin* dl = [self.viewController getCommandInstance:@"FirebaseDynamicLinks"];
    // parse firebase dynamic link
    FIRDynamicLink *dynamicLink = [[FIRDynamicLinks dynamicLinks] dynamicLinkFromCustomSchemeURL:url];
    if (dynamicLink) {
        [dl postDynamicLink:dynamicLink];
        handled = TRUE;
    }
    return handled;
}

- (BOOL)default_application:(UIApplication *)app continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    return FALSE;
}

- (BOOL)swizzled_application:(UIApplication *)app continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    // always call original method implementation first
    BOOL handled = [self swizzled_application:app continueUserActivity:userActivity restorationHandler:restorationHandler];
    FirebaseDynamicLinksPlugin* dl = [self.viewController getCommandInstance:@"FirebaseDynamicLinks"];
    // handle firebase dynamic link
    return [[FIRDynamicLinks dynamicLinks]
            handleUniversalLink:userActivity.webpageURL
            completion:^(FIRDynamicLink * _Nullable dynamicLink, NSError * _Nullable error) {
        // assign obtained variable to the one to post.
        __block FIRDynamicLink *dynamicLinkToPost;
        
        // creates a group to vobtained the block's value.
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        
        // If `dynamicLink` is filled, just set `dynamicLinkToPost` with it.
        // Otherwise, we need to obtain it from the Universal Link URL.
        if (dynamicLink) {
            dynamicLinkToPost = dynamicLink;
            dispatch_group_leave(group);
        } else {
            // Try this method as some dynamic links are not recognize by handleUniversalLink
            // ISSUE: https://github.com/firebase/firebase-ios-sdk/issues/743
            [[FIRDynamicLinks dynamicLinks]
             dynamicLinkFromUniversalLinkURL:userActivity.webpageURL
             completion:^(FIRDynamicLink * _Nullable alternateDynamicLink, NSError * _Nullable error) {
                dynamicLinkToPost = alternateDynamicLink;
                dispatch_group_leave(group);
            }];
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (dynamicLinkToPost) {
                [dl postDynamicLink:dynamicLinkToPost];
            }
        });
    }] || handled;
}

@end
