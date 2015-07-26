//
//  ViewController.m
//  LatestCalculatorApp
//
//  Created by Arun Jalota on 21/07/15.
//

#import "ViewController.h"

typedef enum {
    Plus,
    Minus,
    Multiply,
    Divide
    
} CalcOperation;

@interface ViewController ()<UITextFieldDelegate> {
    
    // local variables.
    IBOutlet UITextField *display;
    // storage previous value.
    NSString *storage;
    // check operation type.
    CalcOperation operation;
    
    
    BOOL typingNumber;     //check if user is typing a number.
    BOOL floatPoint;       //convert a float number.
    BOOL checkOperators;   //check operation pressed or not.
    
    int count;            //Get the count of display string.
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // set the default value.
    typingNumber    = NO;
    floatPoint      = NO;
    checkOperators  = NO;
    
    count = 0;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - plus Minu button (+/-).
- (IBAction)plusMinusPressed:(id)sender {
    
    if (display.text > 0)
        display.text = [@"-" stringByAppendingString:display.text];
}

#pragma mark - percentage button.
- (IBAction)percentagePressed:(id)sender {
    
    display.text = [NSString stringWithFormat:@"%g",[display.text floatValue] / 100];
}


#pragma mark - number Action.
- (IBAction)numbers:(UIButton *)sender {
    
    // fetch the value from tags
    // Set tags according to numbers
    NSString *number = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    
    NSLog(@"%lu",(unsigned long)display.text.length);
    
    if (count <= 9) {
        
            if ([sender tag] == 10) {
                
                    if (checkOperators == YES) {
                        
                            if (typingNumber) {
                                
                                display.text = [display.text stringByAppendingString:number];
                                
                            }else {
                                
                                display.text = @"0.";
                                
                                checkOperators = NO;
                                
                                typingNumber = YES;
                                
                            }// end if else statement.  if (typingNumber)
                        
                        
                    }else {
                        
                        if (![display.text containsString:@"."]) {
                            
                            floatPoint = YES;
                            
                                if ([display.text isEqualToString:@"0"]) {
                                    
                                    display.text = [NSString stringWithFormat:@"0%@",number];
                                    
                                    typingNumber = YES;
                                    
                                }else {
                                    
                                            if (typingNumber) {
                                                
                                                display.text = [display.text stringByAppendingString:number];
                                                
                                            }else {
                                                
                                                display.text = number;
                                                
                                                typingNumber = YES;
                                                
                                            }// end if else statement.if (typingNumber)
                                    
                                }// end if else statement.if ([display.text isEqualToString:@"0"])
                            
                         }// end if else statement.if (![display.text containsString:@"."])
                        
                    }// end if else statement.if (checkOperators == YES)
                
            }else {
                
                    if (typingNumber) {
                        
                        display.text = [display.text stringByAppendingString:number];
                        
                    }else {
                        
                        display.text = number;
                        
                        typingNumber = YES;
                        
                    }// end if else statement.if (typingNumber)
                
            }// end if else statement. if ([sender tag] == 10)
        
    }// end if else statement. if (count <= 9)
    
    count = (int)display.text.length; //Get the character
}


#pragma mark - perform arithmetic operations.
- (IBAction)arithmeticOperations:(id)sender {
    
    checkOperators = YES;
    
    // fetch the value from tags
    // set tag div = 0, mul = 1, sub = 2, add = 3.
    switch ([sender tag])
    {
        case 1:
            operation = Multiply;
            storage = display.text;
            break;
            
        case 2:
            operation = Minus;
            storage = display.text;
            break;
            
        case 3:
            operation = Plus;
            storage = display.text;
            break;
            
        case 0:
            operation = Divide;
            storage = display.text;
            break;
            
        default:
            break;
    }
    
    typingNumber = NO;
    floatPoint   = NO;
    count = 0;
    
}

#pragma mark - perform equal to button action.
- (IBAction) equalsbutton {
    
    NSString *val = display.text;
    
    switch(operation) {
            
        case Plus :
            display.text = [NSString stringWithFormat:@"%g",[val floatValue]+[storage floatValue]];
            break;
            
        case Minus:
            display.text = [NSString stringWithFormat:@"%g",[storage floatValue]-[val floatValue]];
            break;
            
        case Divide:
            display.text = [NSString stringWithFormat:@"%g",[storage floatValue]/[val floatValue]];
            break;
            
        case Multiply:
            display.text = [NSString stringWithFormat:@"%g",[val floatValue]*[storage floatValue]];
            break;
            
    }
}


#pragma mark - clear Display
- (IBAction) clearDisplay {
    
    display.text = @"0";
    
    typingNumber = NO;
    
}


@end
