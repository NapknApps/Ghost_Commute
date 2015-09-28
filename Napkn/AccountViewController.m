//
//  AccountViewController.m
//  Napkn
//
//  Created by Zach Whelchel on 7/16/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "AccountViewController.h"
#import "SignUpViewController.h"
#import "LogInViewController.h"
#import "FirebaseHelper.h"
#import <Firebase/Firebase.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TwitterAuthHelper.h"

@interface AccountViewController () <SignUpViewControllerDelegate, LogInViewControllerDelegate>

@end

@implementation AccountViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginWithTwitter:(id)sender
{
    Firebase *ref = [FirebaseHelper baseFirebaseReference];
    TwitterAuthHelper *twitterAuthHelper = [[TwitterAuthHelper alloc] initWithFirebaseRef:ref
                                                                                   apiKey:@"EWRJf96UFSWCkt0Qu9LVGKPCq"];
    [twitterAuthHelper selectTwitterAccountWithCallback:^(NSError *error, NSArray *accounts) {
        if (error) {
            // Error retrieving Twitter accounts
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"No Twitter Accounts Found"
                                                  message:@"Have you added your Twitter account in the iOS Settings app?"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               
                                           }];
            
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        } else if ([accounts count] == 0) {
            
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"No Twitter Accounts Found"
                                                  message:@"Have you added your Twitter account in the iOS Settings app?"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               
                                           }];
            
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        } else {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Select a Twitter Account"
                                                  message:nil
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            for (ACAccount *account in accounts) {
                UIAlertAction *accountAction = [UIAlertAction
                                                actionWithTitle:account.username
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action)
                                                {
                                                    [twitterAuthHelper authenticateAccount:account withCallback:^(NSError *error, FAuthData *authData) {
                                                        if (error) {
                                                            // Error authenticating account
                                                        } else {
                                                            // User logged in!
                                                            [self dismissViewControllerAnimated:NO completion:^{
                                                                [self.delegate accountViewControllerDidLogin:self];
                                                            }];
                                                        }
                                                    }];
                                                    
                                                }];
                [alertController addAction:accountAction];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }];
}

- (IBAction)loginWithFacebook:(id)sender
{
    /*
    Firebase *ref = [FirebaseHelper baseFirebaseReference];
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    [facebookLogin logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *facebookResult, NSError *facebookError) {
        if (facebookError) {
            NSLog(@"Facebook login failed. Error: %@", facebookError);
        } else if (facebookResult.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            [ref authWithOAuthProvider:@"facebook" token:accessToken withCompletionBlock:^(NSError *error, FAuthData *authData) {
                if (error) {
                    NSLog(@"Login failed. %@", error);
                } else {
                    NSLog(@"Logged in! %@", authData);
                    
                    [self dismissViewControllerAnimated:NO completion:^{
                        [self.delegate accountViewControllerDidLogin:self];
                    }];
                }
            }];
        }
    }];
    */
}

- (void)signUpViewControllerDidLogin:(SignUpViewController *)signUpViewController
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate accountViewControllerDidLogin:self];
    }];
}

- (void)logInViewControllerDidLogin:(LogInViewController *)logInViewController
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate accountViewControllerDidLogin:self];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignUp"]) {
        SignUpViewController *signUpViewController = (SignUpViewController *)segue.destinationViewController;
        signUpViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"LogIn"]) {
        LogInViewController *logInViewController = (LogInViewController *)segue.destinationViewController;
        logInViewController.delegate = self;
    }
}

@end
