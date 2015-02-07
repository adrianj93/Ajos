//  QuizViewController.m
//  ajos
//
//  Created by Szymon Rz on 01/02/15.
//  Copyright (c) 2015 Adrian Janiak. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"
#import "Question.h"


@interface QuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *HighScore;
@property (weak, nonatomic) IBOutlet UILabel *CurrentScore;
@property (strong, nonatomic) NSMutableArray *questionArray;
@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;


@end

@implementation QuizViewController

- (void) addQuestionArray: (NSString*)text_question answers:(NSNumber*)answers
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Question"    inManagedObjectContext:moc];
    Question *newQ1 = [[Question alloc] initWithEntity:entityDescription
                        insertIntoManagedObjectContext:moc];
    newQ1.question = text_question;
    newQ1.answers = answers;
    [self.questionArray addObject:newQ1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.HighScore.text = [self.players_score stringValue];
    self.CurrentScore.text = [@0 stringValue];
    
    [self addQuestionArray:@"test" answers:@1];
    [self addQuestionArray:@"test2" answers:@0];
    [self addQuestionArray:@"tess3" answers:@1];
    [self addQuestionArray:@"test4" answers:@0];
    [self addQuestionArray:@"test5" answers:@1];
    [self addQuestionArray:@"test6" answers:@0];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Question"];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    self.questionArray = [results mutableCopy];
    
    int row = arc4random() %self.questionArray.count;
    Question *q1 = self.questionArray[row];
    self.QuestionLabel.text = q1.question;
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

