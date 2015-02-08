//
//  Question.h
//  ajos
//
//  Created by Szymon Rz on 07/02/15.
//  Copyright (c) 2015 Adrian Janiak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSNumber * answers;

@end
