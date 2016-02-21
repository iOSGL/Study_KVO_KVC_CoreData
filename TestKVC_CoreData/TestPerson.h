//
//  TestPerson.h
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonJob.h"

@interface TestPerson : NSObject {
    
    NSString *name;
    NSInteger age;
    double weight;
    PersonJob *personJob;
}


@end
