//
//  SecondLevelViewController.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/16/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

// http://img07.deviantart.net/6f79/i/2013/104/d/d/cmc_club_house_inside_01_by_bitterplaguerat-d61rqfo.jpg

#import "SecondLevelViewController.h"
#import <MZTimerLabel.h>
#import "ApplicationManager.h"

NSInteger const countDownTimeLong = 600;
NSInteger const countDownTimeMedium = 300;
NSInteger const countDownTimeShort = 30;

@interface SecondLevelViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *blackboardTextField;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *enteredWordsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *desiredWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *cheerLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainScreenButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *gameSummaryView;
@property (weak, nonatomic) IBOutlet UILabel *levelOneStatus;
@property (weak, nonatomic) IBOutlet UILabel *levelTwoStatus;

@property (strong, nonatomic) NSTimer *endGameTimer;
@end

@implementation SecondLevelViewController {
    NSInteger enteredWordsCounter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    enteredWordsCounter = 0;
    self.cheerLabel.alpha = 0;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.blackboardTextField action:@selector(resignFirstResponder)];
    [self.backgroundView addGestureRecognizer:tapRecognizer];
    self.mainScreenButton.layer.cornerRadius = HelloComputerCornerRadius;
    self.mainScreenButton.hidden = YES;
    self.cheerLabel.numberOfLines = 0;
    
    self.gameSummaryView.alpha = 0;
    self.gameSummaryView.hidden = YES;
    self.gameSummaryView.layer.cornerRadius = 25;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
    HelloComputerDifficultyLevels currentDiffLevel = [[ApplicationManager sharedInstance] secondLevelDifficulty];
    
    switch (currentDiffLevel) {
        case HelloComputerDifficultyEasy:
            [timer setCountDownTime:countDownTimeLong];
            self.endGameTimer = [NSTimer scheduledTimerWithTimeInterval:countDownTimeLong target:self selector:@selector(endGame) userInfo:nil repeats:NO];
            break;
        case HelloComputerDifficultyMedium:
            [timer setCountDownTime:countDownTimeMedium];
            self.endGameTimer = [NSTimer scheduledTimerWithTimeInterval:countDownTimeMedium target:self selector:@selector(endGame) userInfo:nil repeats:NO];
            break;
        case HelloComputerDifficultyHard:
            [timer setCountDownTime:countDownTimeShort];
            self.endGameTimer = [NSTimer scheduledTimerWithTimeInterval:countDownTimeShort target:self selector:@selector(endGame) userInfo:nil repeats:NO];
            break;
    }
    [timer start];
    
    NSArray *wordsList = [self words];
    self.desiredWordLabel.text = [wordsList firstObject];
}

- (IBAction)mainScreenButtonPressed:(id)sender {
    [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

- (void)endGame {
    [self.blackboardTextField resignFirstResponder];
    self.blackboardTextField.userInteractionEnabled = NO;
    self.blackboardTextField.hidden = YES;
    self.mainScreenButton.hidden = NO;
    

    HelloComputerDifficultyLevels currentDiffLevel = [[ApplicationManager sharedInstance] secondLevelDifficulty];
    NSUInteger levelOneBeatTime = [[ApplicationManager sharedInstance] levelOneBeatTime];
    
    switch (currentDiffLevel) {
        case HelloComputerDifficultyEasy:
            if (enteredWordsCounter < 15) {
                self.levelTwoStatus.text = @"слаб резултат";
            }
            else if (enteredWordsCounter >= 15 && enteredWordsCounter < 25) {
                self.levelTwoStatus.text = @"среден резултат";
            }
            else if (enteredWordsCounter >= 25 && enteredWordsCounter < 35) {
                self.levelTwoStatus.text = @"добър резултат";
            }
            else if (enteredWordsCounter >= 35) {
                self.levelTwoStatus.text = @"отличен резултат";
            }
            
            if (levelOneBeatTime < 10) {
                self.levelOneStatus.text = @"отличен резултат";
            }
            else if (levelOneBeatTime >= 10 && levelOneBeatTime < 15) {
                self.levelOneStatus.text = @"добър резултат";
            }
            else if (levelOneBeatTime >= 15 && levelOneBeatTime < 60) {
                self.levelOneStatus.text = @"среден резултат";
            }
            else if (levelOneBeatTime >= 60) {
                self.levelOneStatus.text = @"слаб резултат";
            }
            break;
            
        case HelloComputerDifficultyMedium:
            
            if (enteredWordsCounter < 5 * 15 - 4) {
                self.levelTwoStatus.text = @"слаб резултат";
            }
            else if (enteredWordsCounter >= 5 * 15 - 4 && enteredWordsCounter < 5 * 25 - 4) {
                self.levelTwoStatus.text = @"среден резултат";
            }
            else if (enteredWordsCounter >= 5 * 25 - 4 && enteredWordsCounter < 5 * 35 - 4) {
                self.levelTwoStatus.text = @"добър резултат";
            }
            else if (enteredWordsCounter >= 5 * 35) {
                self.levelTwoStatus.text = @"отличен резултат";
            }
            
            if (levelOneBeatTime < 20) {
                self.levelOneStatus.text = @"отличен резултат";
            }
            else if (levelOneBeatTime >= 20 && levelOneBeatTime < 35) {
                self.levelOneStatus.text = @"добър резултат";
            }
            else if (levelOneBeatTime >= 35 && levelOneBeatTime < 100) {
                self.levelOneStatus.text = @"среден резултат";
            }
            else if (levelOneBeatTime >= 100) {
                self.levelOneStatus.text = @"слаб резултат";
            }
            break;
            
        case HelloComputerDifficultyHard:
            if (enteredWordsCounter < 10 * 15 - 15) {
                self.levelTwoStatus.text = @"слаб резултат";
            }
            else if (enteredWordsCounter >= 10 * 15 - 15 && enteredWordsCounter < 10 * 25 - 15) {
                self.levelTwoStatus.text = @"среден резултат";
            }
            else if (enteredWordsCounter >= 10 * 25 - 15 && enteredWordsCounter < 10 * 35 - 15) {
                self.levelTwoStatus.text = @"добър резултат";
            }
            else if (enteredWordsCounter >= 10 * 35) {
                self.levelTwoStatus.text = @"отличен резултат";
            }
            
            if (levelOneBeatTime < 25) {
                self.levelOneStatus.text = @"отличен резултат";
            }
            else if (levelOneBeatTime >= 25 && levelOneBeatTime < 45) {
                self.levelOneStatus.text = @"добър резултат";
            }
            else if (levelOneBeatTime >= 45 && levelOneBeatTime < 120) {
                self.levelOneStatus.text = @"среден резултат";
            }
            else if (levelOneBeatTime >= 120) {
                self.levelOneStatus.text = @"слаб резултат";
            }
            break;
    }
    
    self.gameSummaryView.alpha = 0;
    self.gameSummaryView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.gameSummaryView.alpha = 1;
    } completion:^(BOOL finished) {
        self.gameSummaryView.alpha = 1;
    }];
}

- (NSArray *)words {

    NSArray *wordsArr = @[@"Здравей", @"аз", @"ти", @"той", @"ние", @"вие", @"те", @"това", @"онова", @"тук", @"там", @"кой", @"какъв", @"къде", @"кога", @"как", @"не", @"всички", @"цял", @"целият", @"много", @"няколко", @"малко", @"друг", @"едно", @"две", @"три", @"четири", @"пет", @"голям", @"дълъг", @"широк", @"плътен", @"дебел", @"тежък", @"малък", @"дребен", @"къс", @"кратък", @"тесен", @"слаб", @"тънък", @"жена", @"мъж", @"човек", @"дете", @"съпруга", @"съпруг", @"майка", @"баща", @"татко", @"животно", @"риба", @"птица", @"куче", @"въшка", @"змия", @"червей", @"дърво", @"гора", @"пръчка", @"съчка", @"клонче", @"клечка", @"стрък", @"плод", @"семе", @"листо", @"лист", @"корен", @"кора", @"цвете", @"трева", @"въже", @"кожа", @"месо", @"кръв", @"кокал", @"кост", @"яйце", @"опашка", @"перо", @"коса", @"косъм", @"глава", @"ухо", @"око", @"нос", @"уста", @"зъб", @"език", @"нокът", @"пия", @"ям", @"хапя", @"виждам", @"чувам", @"слушам", @"зная", @"мисля", @"мириша"];
    
    NSMutableArray *shuffledArray = [NSMutableArray arrayWithArray:wordsArr];
    NSUInteger count = shuffledArray.count;
    
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [NSArray arrayWithArray:shuffledArray];
}

- (NSArray *)cheers {
    NSArray *wordsArr = @[@"Браво!", @"Ура!", @"Благодаря, Божко!", @"Много добре!", @"Отлично!", @"Страхотно!"];
    NSMutableArray *shuffledArray = [NSMutableArray arrayWithArray:wordsArr];
    NSUInteger count = shuffledArray.count;
    
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [NSArray arrayWithArray:shuffledArray];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([textField.text isEqualToString:self.desiredWordLabel.text]) {
        
        self.cheerLabel.text = [NSString stringWithFormat:@"%@\n%@",textField.text, [[self cheers] firstObject]];
        self.cheerLabel.alpha = 1;
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.cheerLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.cheerLabel.alpha = 0;
        }];
        
        self.desiredWordLabel.text = [[self words] firstObject];
        self.enteredWordsCountLabel.text = [NSString stringWithFormat:@"Въведени Думи: %ld", (long)++enteredWordsCounter];
        textField.text = @"";
    }
    return NO;
}

@end
