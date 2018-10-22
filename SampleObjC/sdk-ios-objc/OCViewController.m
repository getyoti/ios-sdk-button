//
//  ViewController.m
//  sdk-ios-objc
//
//  Created by Simon Hamadene on 16/10/2018.
//  Copyright © 2018 Yoti Limited. All rights reserved.
//

#import "OCViewController.h"
#import <YotiButtonSDK/YotiButtonSDK.h>
#import "OCProfileViewController.h"

@interface OCViewController () <YTBSDKDelegate, YTBBackendDelegate>
@property (weak, nonatomic) IBOutlet YotiButton *rememberMe;
@property (weak, nonatomic) IBOutlet YotiButton *selfieAuth;
@end

@implementation OCViewController {
    NSArray *responseObject;
}
- (IBAction)buttonDidTouchUpInside:(YotiButton*)sender {
    
    NSString* useCaseID = sender.useCaseID;
    NSError* error = nil;
    
    if (![useCaseID isEqual:@""]) {
        [YotiSDK startScenarioForUseCaseID:useCaseID withDelegate:self error:&error];
        
        if (error != nil) {
            NSLog(@"error : %@", error.description);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rememberMe setTitle:@"OC RememberMe Scenario" forState: UIControlStateNormal ];
    [self.selfieAuth setTitle:@"OC SelfieAuth Scenario" forState: UIControlStateNormal ];
}

-(void) moveToProfile {
    [self performSegueWithIdentifier:@"moveToProfile" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"moveToProfile"])
    {
        OCProfileViewController* profileViewController = [segue destinationViewController];
        
        for (id element in responseObject) {
            NSString* key = [element objectForKey:@"name"];
            id value = [element objectForKey:@"value"];
            if ([key isEqual:@"selfie"]) {
                NSData* imageData = [[NSData alloc] initWithBase64EncodedString:(NSString*)value options:0];
                UIImage* photo = [[UIImage alloc] initWithData:imageData];
                profileViewController.selfie = photo;
            }
            if ([key isEqual:@"phone_number"]) {
                profileViewController.phone = (NSString*)value;
            }
            if ([key isEqual:@"given_names"]) {
                profileViewController.givenNames = (NSString*)value;
            }
            if ([key isEqual:@"postal_address"]) {
                profileViewController.postalAddress = (NSString*)value;
            }
            if ([key isEqual:@"gender"]) {
                profileViewController.gender = (NSString*)value;
            }
            if ([key isEqual:@"email_address"]) {
                profileViewController.emailAddress = (NSString*)value;
            }
            if ([key isEqual:@"family_name"]) {
                profileViewController.familyName = (NSString*)value;
            }
            if ([key isEqual:@"date_of_birth"]) {
                profileViewController.dateOfBirth = (NSString*)value;
            }
        }
    }
    
}

- (void)yotiSDKDidFailFor:(NSString * _Nonnull)useCaseID with:(NSError * _Nonnull)error {
    NSLog(@"yotiSDKDidFailFor useCaseID: %@,  with error: %@", useCaseID, error.localizedDescription);
}

- (void)yotiSDKDidSucceedFor:(NSString * _Nonnull)useCaseID baseURL:(NSURL * _Nullable)baseURL token:(NSString * _Nullable)token url:(NSURL * _Nullable)url {
    YTBScenario *scenario = [YotiSDK scenarioforUseCaseID:useCaseID];
    [YotiSDK callbackBackendScenario:scenario token:token withDelegate:self];
}

- (void)backendDidFinishWith:(NSData * _Nullable)data error:(NSError * _Nullable)error {
    if (data != nil) {
        NSError *jsonError = nil;
        responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        [self moveToProfile];
    }
}

- (void)yotiSDKDidOpenYotiApp {
    NSLog(@"yotiSDKDidOpenYotiApp");
}


@end
