//
//  DatabaseController.m
//  SmartWidget
//
//  Created by Shahil Shah on 02/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "DatabaseController.h"
#import "constants.h"
#import "TestData.h"
#import <sqlite3.h>

@implementation DatabaseController

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSMutableArray*)selectFromEscala:(NSString*)sql {
    NSMutableArray *dataTuples = [[NSMutableArray alloc] init];
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;
//        const char *sql;
//        sql = "SELECT * FROM escala";
        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            // Read the data from the result row
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSString stringWithFormat:@"%d", (int)sqlite3_column_int(sqlStmt, 0)] forKey:DB_FIELD_ID];
            [dict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)] forKey:DB_FIELD_ESCALA];
            [dataTuples addObject:dict];
            [dict release], dict = nil;
        }
        // Release the compiled statement from memory
        sqlite3_finalize(sqlStmt);
        sqlite3_close(database);
    }
    return [dataTuples autorelease];
}

- (NSString*)getTestDescription:(NSString*)sql {
    NSString *textDescription;
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            if ((char *)sqlite3_column_text(sqlStmt, 0) != NULL) {
                textDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 0)];
            }
            else {
                textDescription = @"";
            }
        }
    }
    return textDescription;
}

- (NSDictionary*)getResultString:(NSString*)sql {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            NSString *descripcion1, *descripcion2;
            if ((char *)sqlite3_column_text(sqlStmt, 0) != NULL) {
                descripcion1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 0)];
            }
            else {
                descripcion1 = @"";
            }
            if ((char *)sqlite3_column_text(sqlStmt, 1) != NULL) {
                descripcion2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)];
            }
            else {
                descripcion2 = @"";
            }
            [dict setObject:descripcion1 forKey:DB_FIELD_DESCRIPCION1];
            [dict setObject:descripcion2 forKey:DB_FIELD_DESCRIPCION2];
        }
    }
    return [dict autorelease];
}

- (NSMutableArray*)selectFromPreguntas:(NSString*)sql {
    NSMutableArray *dataTuples = [[NSMutableArray alloc] init];
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            // Read the data from the result row
            TestData *testData = [[TestData alloc] init];
            
            if ((char *)sqlite3_column_text(sqlStmt, 1) == NULL)
                testData.r3 = @"";
            else
                testData.r3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 2) == NULL)
                testData.r4 = @"";
            else
                testData.r4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 2)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 3) == NULL)
                testData.r5 = @"";
            else
                testData.r5 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 3)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 4) == NULL)
                testData.r6 = @"";
            else
                testData.r6 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 4)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 5) == NULL)
                testData.pregunta = @"";
            else
                testData.pregunta = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 5)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 6) == NULL)
                testData.r1 = @"";
            else
                testData.r1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 6)];
            
            if ((char *)sqlite3_column_text(sqlStmt, 7) == NULL)
                testData.r2 = @"";
            else
                testData.r2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 7)];
            
            testData.v[0] = (int)sqlite3_column_int(sqlStmt, 8);
            testData.v[1] = (int)sqlite3_column_int(sqlStmt, 9);
            
            if ((char *)sqlite3_column_text(sqlStmt, 10) == NULL)
                testData.r7 = @"";
            else
                testData.r7 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 10)];
            
            testData.v[6] = (int)sqlite3_column_int(sqlStmt, 11);
            testData.orden = (int)sqlite3_column_int(sqlStmt, 12);
            testData.multiple = (int)sqlite3_column_int(sqlStmt, 13);
            
            if ((char *)sqlite3_column_text(sqlStmt, 14) == NULL)
                testData.imageName = @"";
            else
                testData.imageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 14)];
            
            testData.escala_id =  (int)sqlite3_column_int(sqlStmt, 15);
            testData.v[2] = (int)sqlite3_column_int(sqlStmt, 16);
            testData.v[3] = (int)sqlite3_column_int(sqlStmt, 17);
            testData.v[4] = (int)sqlite3_column_int(sqlStmt, 18);
            testData.v[5] = (int)sqlite3_column_int(sqlStmt, 19);
            
            [dataTuples addObject:testData];
            [testData release], testData = nil;
        }
        // Release the compiled statement from memory
        sqlite3_finalize(sqlStmt);
        sqlite3_close(database);
    }
    return [dataTuples autorelease];
}
@end
