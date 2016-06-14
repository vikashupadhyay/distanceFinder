//
//  ViewController.m
//  distanceFinder
//
//  Created by kvikas on 6/13/16.
//  Copyright © 2016 kvikas. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startingLocation;
@property (weak, nonatomic) IBOutlet UITextField *firstLocation;
@property (weak, nonatomic) IBOutlet UITextField *secondLocation;
@property (weak, nonatomic) IBOutlet UITextField *thirdLocation;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UILabel *DestA;
@property (weak, nonatomic) IBOutlet UILabel *DestB;
@property (weak, nonatomic) IBOutlet UILabel *DestC;

@property(nonatomic) DGDistanceRequest *req;
@end

@implementation ViewController
- (void)viewDidLoad {
    [self removeKeyBoard];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculatepressed:(id)sender {
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    
    NSString *startingLocation =  self.startingLocation.text;
    NSString *firstLocation =  self.firstLocation.text;
    NSString *secondLocation =  self.secondLocation.text;
    NSString *thirdLocation =  self.thirdLocation.text;
     NSArray *dest = @[firstLocation,secondLocation,thirdLocation];
    
    __weak ViewController *weakself = self;
    
  self.req =  [self.req initWithLocationDescriptions:dest sourceDescription:startingLocation];
    
    self.req.callback = ^(NSArray *response){
        ViewController *strongself = weakself;
        if(!strongself)  return;
        
        NSNull *badRequest  =[NSNull null];
        
        if(response[0]!=badRequest){
            double num = [response[0] doubleValue]/1000.0;
            
            NSString *x = [NSString stringWithFormat:@"%0.2f km",num];
            self.DestA.text = x;
        }
        
        if(response[1]!=badRequest){
            double num = [response[1] doubleValue]/1000.0;
            
            NSString *x = [NSString stringWithFormat:@"%0.2f km",num];
            self.DestB.text = x;
        }
        
        if(response[2]!=badRequest){
            double num = [response[2] doubleValue]/1000.0;
            
            NSString *x = [NSString stringWithFormat:@"%0.2f km",num];
            self.DestC.text = x;
        }
        self.calculateButton.enabled = YES;
    };
    
    [self.req start];
    
}

-(void) removeKeyBoard{
    UIGestureRecognizer *tapper;
    tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}


@end
