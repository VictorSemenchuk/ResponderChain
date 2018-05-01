//
//  ResponderDemoView.h
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAX_ELAPSED_TIME 2

typedef enum {
    s0,
    s1,
    s2
} State;

@interface ResponderDemoView : UIView {
    State state;
    float movedTogether, movedSeparate;
    float accDistance;
    CGPoint firstTouchLocInView;
    NSTimeInterval firstTouchTimeStamp;
}
@end
