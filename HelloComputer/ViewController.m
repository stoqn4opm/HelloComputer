//
//  ViewController.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/15/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import "ViewController.h"
#import "ApplicationManager.h"

NSString * const storySegue = @"storySegue";
NSString * const settingsSegue = @"settingsSegue";

NSUInteger const autoStartGameTime = 60;

@interface ViewController ()

@property (strong, nonatomic) NSTimer *autoStartTimer;

@property (weak, nonatomic) IBOutlet UILabel *AFKMessage;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.autoStartTimer = [NSTimer scheduledTimerWithTimeInterval:autoStartGameTime target:self selector:@selector(autoStartGame) userInfo:nil repeats:NO];
    self.AFKMessage.alpha = 0;
    self.AFKMessage.hidden = YES;
}

- (void)autoStartGame {
    self.AFKMessage.hidden = NO;
    [UIView animateWithDuration:2 animations:^{
        self.AFKMessage.alpha = 1;
    } completion:^(BOOL finished) {
        self.AFKMessage.alpha = 1;
    }];
    
    [[ApplicationManager sharedInstance] setSecondLevelDifficulty:HelloComputerDifficultyEasy];
    [[ApplicationManager sharedInstance] setFirstLevelDifficulty:HelloComputerDifficultyEasy];
    
    UITapGestureRecognizer *startGame = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startGamePressed:)];
    [self.view addGestureRecognizer:startGame];
}

- (IBAction)startGamePressed:(id)sender {
    [self performSegueWithIdentifier:storySegue sender:nil];
    [self.autoStartTimer invalidate];
    self.autoStartTimer = nil;
    self.AFKMessage.alpha = 0;
    self.AFKMessage.hidden = YES;
}

- (IBAction)settingsPressed:(id)sender {
    [self performSegueWithIdentifier:settingsSegue sender:nil];
    [self.autoStartTimer invalidate];
    self.autoStartTimer = nil;
    self.AFKMessage.alpha = 0;
    self.AFKMessage.hidden = YES;
}

@end
