//
//  ViewController.m
//  sdk-ios-objc
//
//  Created by Simon Hamadene on 16/10/2018.
//  Copyright © 2018 Yoti Limited. All rights reserved.
//

#import "ViewController.h"
#import <YotiButtonSDK/YotiButtonSDK.h>
#import "ProfileViewController.h"

@interface ViewController () <YTBScenarioRetrievalDelegate, YTBBackendDelegate>
@property (weak, nonatomic) IBOutlet YotiButton *rememberMeButton;
@property (weak, nonatomic) IBOutlet YotiButton *selfieAuthButton;

@end

@implementation ViewController {
    NSDictionary *responseObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rememberMeButton setTitle:@"RememberMe Scenario" forState: UIControlStateNormal ];
    [self.selfieAuthButton setTitle:@"SelfieAuth Scenario" forState: UIControlStateNormal ];
}

-(void) moveToProfile {
    [self performSegueWithIdentifier:@"moveToProfile" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"moveToProfile"])
    {
        ProfileViewController* profileViewController = [segue destinationViewController];
        
        NSData* selfieValue = [responseObject objectForKey:@"selfie"];
        if (selfieValue != nil) {
            NSData* imageData = [[NSData alloc] initWithData:selfieValue];
            profileViewController.selfie = [[UIImage alloc] initWithData:imageData];
        }
        NSString* phoneNumberValue = [responseObject objectForKey:@"phone_number"];
        if ( ![phoneNumberValue isEqual:@""]) {
            profileViewController.phone = phoneNumberValue;
        }
        NSString* givenNamesValue = [responseObject objectForKey:@"given_names"];
        if ( ![givenNamesValue isEqual:@""]) {
            profileViewController.givenNames = givenNamesValue;
        }
        NSString* postalAddressValue = [responseObject objectForKey:@"postal_address"];
        if ( ![postalAddressValue isEqual:@""]) {
            profileViewController.postalAddress = postalAddressValue;
        }
        NSString* genderValue = [responseObject objectForKey:@"gender"];
        if ( ![genderValue isEqual:@""]) {
            profileViewController.gender = genderValue;
        }
        NSString* emailAddressValue = [responseObject objectForKey:@"email_address"];
        if ( ![emailAddressValue isEqual:@""]) {
            profileViewController.emailAddress = emailAddressValue;
        }
        NSString* familyNameValue = [responseObject objectForKey:@"family_name"];
        if ( ![familyNameValue isEqual:@""]) {
            profileViewController.familyName = familyNameValue;
        }
        NSString* dateOfBirthValue = [responseObject objectForKey:@"date_of_birth"];
        if ( ![dateOfBirthValue isEqual:@""]) {
            profileViewController.dateOfBirth = dateOfBirthValue;
        }
    }
    
}

- (void)yotiSDKDidFailFor:(NSString * _Nonnull)useCaseID with:(NSError * _Nonnull)error {
}

- (void)yotiSDKDidSucceedFor:(NSString * _Nonnull)useCaseID baseURL:(NSURL * _Nullable)baseURL token:(NSString * _Nullable)token url:(NSURL * _Nullable)url {
    YTBScenario *scenario = [YotiSDK scenarioforUseCaseID:useCaseID];
    
    [YotiSDK callbackBackendScenario:scenario token:token withDelegate:self];
}

- (void)backendDidFinishWith:(NSData * _Nullable)data error:(NSError * _Nullable)error {
    
    if (data != nil) {
        NSError *jsonError = nil;
        
        responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    }
    
}


@end
