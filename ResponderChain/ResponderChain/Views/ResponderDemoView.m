//
//  ResponderDemoView.m
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ResponderDemoView.h"

@implementation ResponderDemoView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        state = s0;
        movedTogether = movedSeparate = 0;
        accDistance = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSString *message = [NSString stringWithFormat:@"Moved together %.0f%% of the time.", (movedSeparate + movedTogether) ? 100 * (movedTogether / (movedTogether + movedSeparate)) : 100.0];
    [message drawAtPoint:CGPointMake(10, 100) withAttributes:nil];
    
    message = [NSString stringWithFormat:@"Average distance: %4.2f.", movedTogether ? accDistance / movedTogether : 0.0];
    [message drawAtPoint:CGPointMake(10, 150) withAttributes:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int noTouchesInEvent = ((NSSet *)[event allTouches]).count;
    int noTouchesBegan = touches.count;
    NSLog(@"began %i, total %i", noTouchesBegan, noTouchesInEvent);
    if ((noTouchesBegan == 2) && (noTouchesInEvent == 2)) {
        NSArray *touchArray = [touches allObjects];
        state = s1;
        movedTogether = 1;
        movedSeparate = 0;
        accDistance = [self distanceFrom:[[touchArray objectAtIndex:0] locationInView:self] to:[[touchArray objectAtIndex:1] locationInView:self]];
    } else if ((state != s2) && ((noTouchesInEvent == 1) && (noTouchesBegan == 1))) {
        state = s2;
        UITouch *aTouch = (UITouch *)[touches anyObject];
        firstTouchTimeStamp = [aTouch timestamp];
        firstTouchLocInView = [aTouch locationInView:self];
    } else if ((state == s2) && (noTouchesInEvent == 2)) {
        UITouch *aTouch = (UITouch *)[touches anyObject];
        if ((aTouch.timestamp - firstTouchTimeStamp) <= MAX_ELAPSED_TIME) {
            state = s1;
            movedTogether = 1;
            movedSeparate = 0;
            accDistance = [self distanceFrom:[aTouch locationInView:self] to:firstTouchLocInView];
        } else {
            firstTouchTimeStamp = [aTouch timestamp];
            firstTouchLocInView = [aTouch locationInView:self];
        }
    } else {
        state = s0;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"moved %i %i", touches.count, ((NSSet *)[event allTouches]).count);
    NSArray *allTouches = [touches allObjects];
    if ((state == s1) && ([touches count] == 2)) {
        movedTogether++;
        accDistance += [self distanceFrom:[[allTouches objectAtIndex:0] locationInView:self] to:[[allTouches objectAtIndex:1] locationInView:self]];
    } else if ((state == s1) && ([touches count] == 1)) {
        movedSeparate++;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"ended %i %i", touches.count, ((NSSet *)[event allTouches]).count);
    if ((state == s1) && ([touches count] == 2)) {
        NSLog(@"started together and ended together,"
              "moved together %.0f%% "
              "of the time. AVG distance: %4.2f",
              (movedSeparate + movedTogether) ?
              100 * (movedTogether / (movedTogether + movedSeparate)) : 100.0,
              movedTogether ? accDistance / movedTogether : 0.0);
        [self setNeedsDisplay];
    }
    state = s0;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    state = s0;
    movedTogether = movedSeparate = 0;
    accDistance = 0;
}

- (float)distanceFrom:(CGPoint)a to:(CGPoint)b {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}

@end
