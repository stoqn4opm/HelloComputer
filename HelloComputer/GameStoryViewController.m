//
//  GameStoryViewController.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/16/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import "GameStoryViewController.h"

NSString * const firstLevelSegue = @"firstLevelSegue";
NSUInteger const autoStartFirstLevelTime = 60;

@interface GameStoryViewController ()

@property (strong, nonatomic) NSTimer *startTimer;

@end

@implementation GameStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startTimer = [NSTimer timerWithTimeInterval:autoStartFirstLevelTime target:self selector:@selector(startFirstLevel) userInfo:nil repeats:NO];
    
    UITapGestureRecognizer *startGameRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startFirstLevel)];
    startGameRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:startGameRecognizer];
}

- (void) startFirstLevel {
    [self performSegueWithIdentifier:firstLevelSegue sender:nil];
    [self.startTimer invalidate];
    self.startTimer = nil;
}

@end
