//
//  FirstLevelViewController.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/16/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "ApplicationManager.h"
#import <UIView+DragDrop.h>

NSString * secondLevelStorySegue = @"secondLevelSegue";

// hedgehog sprite - http://img15.hostingpics.net/pics/9337783ebac196.png

@interface FirstLevelViewController () <UIViewDragDropDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIImageView *hedgehogView;
@property (weak, nonatomic) IBOutlet UIView *hedgehogBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *goalView;
@property (strong, nonatomic) NSTimer *beatTimeTimer;

@end

@implementation FirstLevelViewController {
    NSUInteger tickCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    tickCount = 0;
    
    HelloComputerDifficultyLevels currentDiff = [[ApplicationManager sharedInstance] firstLevelDifficulty];
    switch (currentDiff) {
        case HelloComputerDifficultyEasy: {
            self.backgroundView.image = [UIImage imageNamed:@"level1d1"];
            break;
        }
        case HelloComputerDifficultyMedium: {
            self.backgroundView.image = [UIImage imageNamed:@"level1d2"];
            break;
        }
        case HelloComputerDifficultyHard: {
            self.backgroundView.image = [UIImage imageNamed:@"level1d3"];
            break;
        }
    }
    
    [self.hedgehogBackgroundView setUserInteractionEnabled:YES];
    [self.hedgehogBackgroundView makeDraggableWithDropViews:@[self.goalView] delegate:self];
    
    self.beatTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

- (void)timerTick {
    tickCount++;
}

- (void)view:(UIView *)view wasDroppedOnDropView:(UIView *)drop {
    [self performSegueWithIdentifier:secondLevelStorySegue sender:nil];
    [self.beatTimeTimer invalidate];
    self.beatTimeTimer = nil;
    [[ApplicationManager sharedInstance] setLevelOneBeatTime:tickCount];
}

@end
