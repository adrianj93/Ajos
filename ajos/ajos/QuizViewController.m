//  QuizViewController.m
//  ajos
//
//  Created by Szymon Rz on 01/02/15.
//  Copyright (c) 2015 Adrian Janiak. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"
#import "Question.h"
#import "ViewController.h"


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
@property (weak, nonatomic) IBOutlet UIButton *BackButton;
@property (weak, nonatomic) IBOutlet UILabel *NrPytLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Heart3;

@property (weak, nonatomic) IBOutlet UIImageView *Heart2;
@property (weak, nonatomic) IBOutlet UIImageView *Hear1;
@property (weak, nonatomic) IBOutlet UILabel *PytanieLabel;
@property int ktore_pytanie;

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
    self.BackButton.hidden = true;
    self.licznik = 1;
    self.life = 3;
    self.ktore_pytanie = 1;
    self.CurrentScore.text = [@0 stringValue];
    [self addQuestionArray:@"Czy lipiec ma 31 dni?" answers:@1]; //true
    [self addQuestionArray:@"Czy wojna stuletnia trwała 100 lat?" answers:@0]; //false
    [self addQuestionArray:@"Czy aborcja to uznanie cudzego dziecka za swoje?" answers:@0];
    [self addQuestionArray:@"Czy po kanale weneckim pływają żaglówki?" answers:@0];
    [self addQuestionArray:@"Czy tradycyjny napój Anglików to herbata z mlekiem?" answers:@1];
    [self addQuestionArray:@"Czy rybi tłuszcz to smalec?" answers:@0];
    [self addQuestionArray:@"Ocean Arktyczny to największy ocean na świecie?" answers:@0];
    [self addQuestionArray:@"Czy najstarszy uniwersytet w Polsce to UAM w Poznaniu?" answers:@0];
    [self addQuestionArray:@"Czy założyciel firmy samochodowej Ford miał na imię Harrison?" answers:@0];
    [self addQuestionArray:@"Czy o Pojezierzu Mazurskim mówi się \"Kraina Tysiąca Jezior\"?" answers:@1];
    [self addQuestionArray:@"Czy w Wieliczce znajduje się rezerwat przyrody nieożywionej - kopalnia soli?" answers:@1];
    [self addQuestionArray:@"Czy czarna skrzynka w samolotach jest pomarańczowa?" answers:@1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.HighScore.text = [self.players_score stringValue];

    //self.CurrentScore.text = [@(self.score) stringValue];
    //to trzeba dać gdziś indziej bo za kazdym razem dodaje sie to do bazy danych
    if (self.licznik !=1)
        [self addQuestion];
    
    if (self.life == 3)
    {
        self.Heart3.image = [UIImage imageNamed:@"Serce_filled.png"];
        self.Heart2.image = [UIImage imageNamed:@"Serce_filled.png"];
        self.Hear1.image = [UIImage imageNamed:@"Serce_filled.png"];
        
    }
    if (self.life == 2)
    {
        self.Heart3.image = [UIImage imageNamed:@"Serce_empty.png"];
        self.Heart2.image = [UIImage imageNamed:@"Serce_filled.png"];
        self.Hear1.image = [UIImage imageNamed:@"Serce_filled.png"];
        
    }
    if (self.life == 1)
    {
        self.Heart3.image = [UIImage imageNamed:@"Serce_empty.png"];
        self.Heart2.image = [UIImage imageNamed:@"Serce_empty.png"];
        self.Hear1.image = [UIImage imageNamed:@"Serce_filled.png"];
    }
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Question"];
    NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
    self.questionArray = [results mutableCopy];
    
    self.wylosowanepytanie = arc4random() %self.questionArray.count;
    Question *q1 = self.questionArray[self.wylosowanepytanie];
    self.QuestionLabel.text = q1.question;
    // Do any additional setup after loading the view.
    self.PytanieLabel.text = [NSString stringWithFormat:@"Pytanie %d", self.ktore_pytanie];
    self.ktore_pytanie++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) WrongAnswer
{
    UIAlertController *alertController
    = [UIAlertController alertControllerWithTitle:@"Zla odpowiedz"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:OkAction];
    [self presentViewController:alertController animated:YES completion:nil];
    [self viewDidLoad];
}

- (void) Finish
{
    UIAlertController *alertController
    = [UIAlertController alertControllerWithTitle:@"Koniec gry "
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alertController addAction:OkAction];
    [self presentViewController:alertController animated:YES completion:nil];
    self.TakButton.enabled = false;
    self.NieButton.enabled = false;
    self.BackButton.Hidden = false;
    self.QuestionLabel.hidden = true;
    self.Hear1.image = [UIImage imageNamed:@"Serce_empty.png"];
    self.life = 3;
    //self.players_score = self.CurrentScore.text;
    //int high_score = [self.HighScore.text integerValue];
    //int current_score = [self.CurrentScore.text integerValue];
    //if (high_score < current_score)
    //{
    //    self.HighScore.text = [NSString stringWithFormat:@"%d", current_score];
    //}
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
        self.life -=1;
        if (self.life >= 1)
        {

            [self WrongAnswer];
            
        }
        else
        {
            [self Finish];
        }
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
        self.life -=1;
        if (self.life >= 1)
        {
            [self WrongAnswer];
        }
        else
        {
            
            [self Finish];
        }
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

