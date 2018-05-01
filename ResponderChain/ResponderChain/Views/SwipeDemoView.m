//
//  SwipeDemoView.m
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "SwipeDemoView.h"

#define Y_TOLERANCE 20
#define X_TOLERANCE 100

@implementation SwipeDemoView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        state = s0;
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    NSString *message;
    if (state == s0) {
        [@"\t\t\t\t\t\t\t\t\t\t" drawAtPoint:CGPointMake(10, 100) withAttributes:nil];
        [@"\t\t\t\t\t\t\t\t\t\t" drawAtPoint:CGPointMake(10, 150) withAttributes:nil];
        [@"\t\t\t\t\t\t\t\t\t\t" drawAtPoint:CGPointMake(10, 200) withAttributes:nil];
    }
    if (state == s1) {
        message = [NSString stringWithFormat:@"Started (%.0f, %.0f), ended (%.0f, %.0f)",
                   startLocation.x, startLocation.y,
                   endLocation.x, endLocation.y];
        [message drawAtPoint:CGPointMake(10, 100) withAttributes:nil];
        message = [NSString stringWithFormat:@"Took %4.3f seconds", endTime - startTime];
        [message drawAtPoint:CGPointMake(10, 150) withAttributes:nil];
        if ((fabs(startLocation.y - endLocation.y) <= Y_TOLERANCE) &&
            (fabs(startLocation.x - endLocation.x) >= X_TOLERANCE)) {
            char *direction;
            direction = (endLocation.x > startLocation.x) ? "right" : "left";
            message = [NSString stringWithFormat:@"Perfect %s swipe, speed: %4.3f pts/s", direction, (endTime - startTime) > 0 ? fabs(endLocation.x - startLocation.x) / (endTime / startTime) : 0];
            [message drawAtPoint:CGPointMake(10, 200) withAttributes:nil];
        } else {
            [@"\t\t\t\t\t\t\t\t\t\t" drawAtPoint:CGPointMake(10, 200) withAttributes:nil];
        }
        state = s0;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int noTouchesInEvent = ((NSSet *)[event allTouches]).count;
    int noTouchesBegan = touches.count;
    NSLog(@"began %i, total %i", noTouchesBegan, noTouchesInEvent);
    if ((state == s0) && (noTouchesInEvent == 1) && (noTouchesBegan) == 1) {
        startLocation = [(UITouch *)[touches anyObject] locationInView:self];
        startTime = [(UITouch *)[touches anyObject] timestamp];
        state = s1;
    } else {
        state = s0;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int noTouchesInEvent = ((NSSet *)[event allTouches]).count;
    int noTouchesBegan = touches.count;
    NSLog(@"ended %i, total %i", noTouchesBegan, noTouchesInEvent);
    if ((state == s1) && (noTouchesInEvent == 1) && (noTouchesBegan) == 1) {
        endLocation = [(UITouch *)[touches anyObject] locationInView:self];
        endTime = [(UITouch *)[touches anyObject] timestamp];
        [self setNeedsDisplay];
    }
}

@end
