//
//  SettingsManaer.m
//  HelloComputer
//
//  Created by Stoqn Stoqnov on 2/15/16.
//  Copyright (c) 2016 Stoyan Stoyanov. All rights reserved.
//

#import "ApplicationManager.h"

NSInteger const HelloComputerCornerRadius = 9;

@implementation ApplicationManager

+ (instancetype)sharedInstance {

        static ApplicationManager *sharedSettingsManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSettingsManager = [[self alloc] init];
        });
        return sharedSettingsManager;
    }

- (id)init {
    if (self = [super init]) {
        // here to init properties
    }
    return self;
}

@end
