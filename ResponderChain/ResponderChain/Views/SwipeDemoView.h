//
//  SwipeDemoView.h
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    s0,
    s1
} State;

@interface SwipeDemoView : UIView {
    CGPoint startLocation, endLocation;
    NSTimeInterval startTime, endTime;
    State state;
}
@end
