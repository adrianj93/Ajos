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
@property (weak, nonatomic) IBOutlet UIButton *TakButton;
@property (weak, nonatomic) IBOutlet UIButton *NieButton;
@property int wylosowanepytanie;
@property int score;
@property int licznik;
@property int life;

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

-(void) addQuestion
{
    self.licznik = 1;
    self.life = 3;
    self.CurrentScore.text = [@0 stringValue];
    [self addQuestionArray:@"true" answers:@1];
    [self addQuestionArray:@"test2" answers:@0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HighScore.text = [self.players_score stringValue];
    
    
    //self.CurrentScore.text = [@(self.score) stringValue];
    //to trzeba dać gdziś indziej bo za kazdym razem dodaje sie to do bazy danych
    if (self.licznik !=1)
        [self addQuestion];
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Question"];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    self.questionArray = [results mutableCopy];
    
    self.wylosowanepytanie = arc4random() %self.questionArray.count;
    Question *q1 = self.questionArray[self.wylosowanepytanie];
    self.QuestionLabel.text = q1.question;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TakButtonTapped:(id)sender {
    Question *q11 = self.questionArray[self.wylosowanepytanie];
    if ([q11.answers compare:@1]==0)
    {

        int currentvalue = [self.CurrentScore.text integerValue];
        NSLog(@"odpowiedz prawidlowa dla tak");
        currentvalue = currentvalue + 1;
        self.CurrentScore.text = [NSString stringWithFormat:@"%d", currentvalue];
        [self viewDidLoad];
    }
    else
    {
        
    }
    
}
- (IBAction)NieButtonTapped:(id)sender {
    Question *qq1 = self.questionArray[self.wylosowanepytanie];
    if ([qq1.answers compare:@0]==0)
    {
        int value = [self.CurrentScore.text integerValue];
        NSLog(@"odpowiedz prawidlowa dla nie");
        value = value + 1;
        self.CurrentScore.text = [NSString stringWithFormat:@"%d", value];
        [self viewDidLoad];
    }
    else
    {
        //odejmnij życie i jesli zycie jest mniejsze niz 1 to finish viewcontoller
        
    }
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

