//
//  ViewController.m
//  ajos
//
//  Created by Adrian Janiak on 22.01.2015.
//  Copyright (c) 2015 Adrian Janiak. All rights reserved.


#import "ViewController.h"
#import "Player.h"
#import "AppDelegate.h"
#import "QuizViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSNumber *players_score;
@property (nonatomic, strong) NSString *players_nick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    self.players = [results mutableCopy];

    self.picker.dataSource = self;
    self.picker.delegate = self;


}




// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.players count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return __testpicker[row];
    //return [self.players objectAtIndex:row];
    Player *play = [self.players objectAtIndex:row];
    return play.nick;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    Player *firstPlayer = self.players[row];
    self.players_score = firstPlayer.highScore;
    
    //self.players_nick = firstPlayer.nick;
    
}

- (IBAction)addButtonTapped:(id)sender {
    UIAlertController *alertController
    = [UIAlertController alertControllerWithTitle:@"New player"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *saveAction
    = [UIAlertAction actionWithTitle:@"Save"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 UITextField *nameTextField = alertController.textFields[0];
             AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                                 NSManagedObjectContext *moc = appDelegate.managedObjectContext;
                                 NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Player"    inManagedObjectContext:moc];
                                 Player *newPlayer = [[Player alloc] initWithEntity:entityDescription
                                                              insertIntoManagedObjectContext:moc];
                                 newPlayer.nick = nameTextField.text;
                                 newPlayer.highScore = @0;
                                 [self.players addObject:newPlayer];                    
                                 NSError *error;
                                 [moc save:&error];
                                 if (error) {
                                     NSLog(@"Error: %@", error);    //Poor error handling - do not resemble it ;)
                                 }
                                 [self.picker reloadAllComponents];
                             }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayerScore"]) {
        QuizViewController *viewController = segue.destinationViewController;
        viewController.players_score = self.players_score;
        //viewController.players_nick = self.players_nick;
    }
}

@end
