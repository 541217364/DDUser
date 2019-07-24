//
//  DDStores_DB.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "DBStoreModel.h"

@interface DDStores_DB : NSObject

@property (nonatomic,strong)NSString *m_dbPath;

@property (retain, nonatomic) FMDatabase *m_db;

@property(nonatomic,retain) FMDatabaseQueue *dbQueue;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *menuName;

+ (instancetype)shareInstance;
- (NSString *)getDbPath;
- (BOOL)DeleteAll;
-(BOOL)dropTable;
- (BOOL)createDBWithPath:(NSString*)path withTablename:(NSString *)name;

- (BOOL)createMemuDBWithPath:(NSString*)path withTablename:(NSString *)name;

@end


@interface DDStores_DB (ddStores_footprint)

- (BOOL)addFootprintInfoWtihDict:(NSDictionary *)dict;

- (NSMutableArray *)getFootprintInfoArray;

- (BOOL) deleteFootprintInfo:(DBStoreModel*)info;

- (NSMutableArray *)getFootprintInfoArrayforkey:(NSString *)storeid;

@end

