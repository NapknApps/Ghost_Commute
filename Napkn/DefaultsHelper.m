//
//  DefaultsHelper.m
//  Napkn
//
//  Created by Zach Whelchel on 7/16/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "DefaultsHelper.h"

#define kFirstLaunch @"kFirstLaunch"
#define kIntroShown @"kIntroShown"

@implementation DefaultsHelper

+ (BOOL)isFirstLaunch
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kFirstLaunch];
}

+ (void)setFirstLaunch
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLaunch];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)introShown
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIntroShown];
}

+ (void)setIntroShown
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIntroShown];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
