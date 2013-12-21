//
//  GFBViewController.m
//  GFBeacon
//
//  Created by Marcus Kida on 21.12.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "GFBViewController.h"

static NSString *const kBeaconIdentifier = @"io.kida.GFBeacon";
static NSString *const kBeaconUUID = @"954FBC91-620E-4B5A-86F7-1F31A0054194";

@interface GFBViewController ()
{
    IBOutlet UITextField *_uuidTextField;
    IBOutlet UITextField *_majorIdTextField;
    IBOutlet UITextField *_minorIdTextField;
    
    IBOutlet UISwitch *_activeSwitch;
}

@property (strong) CLBeaconRegion *beaconRegion;
@property (strong) CBPeripheralManager *peripheralManager;

@end

@implementation GFBViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:nil options:nil];

    [_uuidTextField setText:kBeaconUUID];
    [_majorIdTextField setText:@"0"];
    [_minorIdTextField setText:@"0"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction) toggleBeaconActive:(UISwitch *)sw
{
    if (sw.on) {
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:_uuidTextField.text]
                                                                    major:[_majorIdTextField.text intValue]
                                                                    minor:[_minorIdTextField.text intValue]
                                                               identifier:kBeaconIdentifier];
        if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
            [self.peripheralManager startAdvertising:[self.beaconRegion peripheralDataWithMeasuredPower:nil]];
        }
    } else {
        if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
            [self.peripheralManager stopAdvertising];
        }
    }
}

@end
