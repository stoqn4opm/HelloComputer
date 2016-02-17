//
//  SettingsManaer.h
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/15/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(uint8_t, HelloComputerDifficultyLevels) {

    HelloComputerDifficultyEasy = 0,
    HelloComputerDifficultyMedium = 1,
    HelloComputerDifficultyHard = 2
    
};

extern NSInteger const HelloComputerCornerRadius;

@interface ApplicationManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) HelloComputerDifficultyLevels firstLevelDifficulty;
@property (nonatomic, assign) HelloComputerDifficultyLevels secondLevelDifficulty;

@property (nonatomic, assign) NSUInteger levelOneBeatTime;

@end

