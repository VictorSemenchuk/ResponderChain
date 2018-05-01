//
//  AppDelegate.h
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeDemoView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SwipeDemoView *swipeDemoView;
}

@property (strong, nonatomic) UIWindow *window;


@end

