//
//  SettingsViewController.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/16/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import "SettingsViewController.h"
#import "ApplicationManager.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelLevel1;
@property (weak, nonatomic) IBOutlet UILabel *labelLevel2;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.labelLevel1.layer.cornerRadius = HelloComputerCornerRadius;
    self.labelLevel2.layer.cornerRadius = HelloComputerCornerRadius;
    self.backButton.layer.cornerRadius = HelloComputerCornerRadius;
}

#pragma mark - User Actions

- (IBAction)level1DifficultyChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0: {
            [[ApplicationManager sharedInstance] setFirstLevelDifficulty:HelloComputerDifficultyEasy];
            break;
        }
        case 1: {
            [[ApplicationManager sharedInstance] setFirstLevelDifficulty:HelloComputerDifficultyMedium];
            break;
        }
        case 2: {
            [[ApplicationManager sharedInstance] setFirstLevelDifficulty:HelloComputerDifficultyHard];
            break;
        }
        default:
            break;
    }
}

- (IBAction)level2DifficultyChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0: {
            [[ApplicationManager sharedInstance] setSecondLevelDifficulty:HelloComputerDifficultyEasy];
            break;
        }
        case 1: {
            [[ApplicationManager sharedInstance] setSecondLevelDifficulty:HelloComputerDifficultyMedium];
            break;
        }
        case 2: {
            [[ApplicationManager sharedInstance] setSecondLevelDifficulty:HelloComputerDifficultyHard];
            break;
        }
        default:
            break;
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
