//  QuizViewController.m
//  ajos
//
//  Created by Szymon Rz on 01/02/15.
//  Copyright (c) 2015 Adrian Janiak. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"

@interface QuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *HighScore;
@property (weak, nonatomic) IBOutlet UILabel *CurrentScore;
@property (strong, nonatomic) NSArray *questionArray;


@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HighScore.text = [self.players_score stringValue];
    self.CurrentScore.text = [@0 stringValue];
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Question"];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    self.questionArray = [results mutableCopy];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

