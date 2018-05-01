//
//  ResponderTestViewController.m
//  ResponderChain
//
//  Created by Victor Macintosh on 01/05/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ResponderTestViewController.h"
#import "ResponderDemoView.h"

@interface ResponderTestViewController ()
{
    ResponderDemoView *responderView;
}
@end

@implementation ResponderTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    responderView = [[ResponderDemoView alloc] initWithFrame: frame];
    [responderView setMultipleTouchEnabled:YES];
    [responderView setBackgroundColor:[UIColor blueColor]];
    [[self view] addSubview:responderView];
}

- (void)dealloc {
    [responderView dealloc];
    [super dealloc];
}

@end
