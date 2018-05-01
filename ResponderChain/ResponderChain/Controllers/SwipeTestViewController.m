//
//  SwipeTestViewController.m
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "SwipeTestViewController.h"
#import "SwipeDemoView.h"

@interface SwipeTestViewController ()
{
    SwipeDemoView *swipeView;
}
@end

@implementation SwipeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    swipeView = [[SwipeDemoView alloc] initWithFrame:frame];
    [swipeView setMultipleTouchEnabled:YES];
    [swipeView setBackgroundColor:[UIColor redColor]];
    [[self view] addSubview:swipeView];
}

- (void)dealloc {
    [swipeView release];
    [super dealloc];
}


@end
