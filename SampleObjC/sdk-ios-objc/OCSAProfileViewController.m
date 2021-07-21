//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
//

#import "OCSAProfileViewController.h"

@interface OCSAProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *givenNameView;
@property (weak, nonatomic) IBOutlet UILabel *familyNameView;
@property (weak, nonatomic) IBOutlet UILabel *genderView;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressView;
@property (weak, nonatomic) IBOutlet UILabel *postalAddressView;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthView;

@end

@implementation OCSAProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.photoView.image = self.selfie ;
    self.phoneLabel.text = self.phone;
    self.givenNameView.text = self.givenNames;
    self.postalAddressView.text = self.postalAddress;
    self.genderView.text = self.gender;
    self.emailAddressView.text = self.emailAddress;
    self.familyNameView.text = self.familyName;
    self.dateOfBirthView.text = self.dateOfBirth;
}


@end
