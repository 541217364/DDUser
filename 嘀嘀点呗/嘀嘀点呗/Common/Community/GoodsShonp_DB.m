//
//  GoodsShonp_DB.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#define DBSuffix_C @".sqllite"


#import "GoodsShonp_DB.h"

@implementation GoodsShonp_DB

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init])
    {
        self.m_dbPath = [self getDbPath];
        //        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.m_dbPath];
        
        self.m_db = [[FMDatabase alloc] initWithPath:self.m_dbPath];
        
        if (![self.m_db open])
        {
            [self.m_db close];
            NSAssert1(0, @"Failed to open database file with message '%@'.", [self.m_db lastErrorMessage]);
        }
        
        [self.m_db setShouldCacheStatements:YES];
    }
    return self;
}


- (BOOL)createDBWithPath:(NSString*)path withTablename:(NSString *)name
{
    if (path){
        NSLog(@"db path:%@",path);
        
        self.m_dbPath = path;
        
        _name=name;
        
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.m_dbPath];
        
        if (_dbQueue) {
            //   NSArray * parts = CREATE_SQL
            //            for(NSString *str in parts)
            //            {
            
            NSString *sql=[NSString stringWithFormat:@"\CREATE TABLE IF NOT EXISTS  %@ (marking TEXT PRIMARY KEY NOT NULL,storeid TEXT,specId TEXT,goodId TEXT,attributeId TEXT,goodnum TEXT,goodpick TEXT,goodprice TEXT,goodimg TEXT,goodname TEXT,gooddiscountprice TEXT,skillprice TEXT,is_skill TEXT,o_price TEXT,specname TEXT,specprice TEXT,specpick TEXT,atttip TEXT,attributename TEXT,spec_tid TEXT);\
                           "
                           ,name];
            [self.m_db executeUpdate:sql];
            // }
        }
    }
    return YES;
}


- (BOOL)createMemuDBWithPath:(NSString*)path withTablename:(NSString *)name
{
    if (path){
        NSLog(@"db path:%@",path);
        self.m_dbPath = path;
        _name=name;
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.m_dbPath];
        if (_dbQueue) {
            //   NSArray * parts = CREATE_SQL
            //            for(NSString *str in parts)
            //            {
            
            NSString *sql=[NSString stringWithFormat:@"\CREATE TABLE IF NOT EXISTS  %@ (marking TEXT PRIMARY KEY NOT NULL,storeid TEXT,specId TEXT,goodId TEXT,attributeId TEXT,goodnum TEXT,goodpick TEXT,goodprice TEXT,goodimg TEXT,goodname TEXT,gooddiscountprice TEXT,skillprice TEXT,is_skill TEXT,o_price TEXT,specname TEXT,specprice TEXT,specpick TEXT,atttip TEXT,attributename TEXT,spec_tid TEXT);\
                           "
                           ,name];
            [self.m_db executeUpdate:sql];
            // }
        }
    }
    return YES;
}

+(NSString *)getExecuteDocumentsPath
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version == 5.0) {
        // iOS 5 code
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        return documentsDirectory;
    }
    else {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        return documentsDirectory;
    }
}

- (NSString *)getDbPath
{
    NSString *path = [[GoodsShonp_DB getExecuteDocumentsPath] stringByAppendingPathComponent:@"dddb"];
    return [NSString stringWithFormat:@"%@%@",path,DBSuffix_C];
}

#pragma mark -  根据表名往表中插入一条记录
- (BOOL)InsertIntoTableFieldDict:(NSDictionary*)dic tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dic==nil || [dic count]==0) return NO;
    
    NSArray * arrKeys=[dic allKeys];
    NSArray * arrValues=[dic allValues];
    int count=(int)[arrKeys count];
    NSString *sql = [NSString stringWithFormat:@"insert or ignore into %@(",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    for (int i=0; i<count; i++)
    {
        [tempsql appendString:[arrKeys objectAtIndex:i]];
        if(i != count-1)
        {
            [tempsql appendString:@","];
        }
    }
    [tempsql appendString:@") values("];
    for(int k=0; k<count; k++)
    {
        [tempsql appendString:@"?"];
        if(k != count-1)
        {
            [tempsql appendString:@","];
        }
    }
    [tempsql appendString:@")"];
    
   // NSString *msql= [NSString stringWithFormat:@"%@,tempsql];
    
    BOOL isye= [self.m_db executeUpdate:tempsql withArgumentsInArray:arrValues];
    return isye;
}

- (FMResultSet *)QueryIntoTableName:(NSString*)name{
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@",name];
    return [self.m_db executeQuery:sql];
}

- (BOOL)DeleteAll{
    //[self DeleteAllByTableName:_name];
     [self DeleteAllByTableName:@"goodshoptable"];
    
    return YES;
}


-(BOOL)dropTable{
    
    NSString *sql = [NSString stringWithFormat:@"drop table goodshoptable"];
    
    BOOL  result = [self.m_db executeUpdate:sql];
    
    if (result) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - 删除某个表的所有记录
- (BOOL)DeleteAllByTableName:(NSString*)name
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",name];
    
    [self.m_db executeUpdate:sql];
    
    return YES;
}

#pragma mark - 删除满足所有and条件的记录
- (BOOL)DeleteBycondition:(NSDictionary*)dicCondtion tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dicCondtion==nil || [dicCondtion count]==0) return NO;
    
    NSArray * arrKeys=[dicCondtion allKeys];
    NSArray * arrValues=[dicCondtion allValues];
    int count=(int)[arrKeys count];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where ",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    for (int i=0; i<count; i++)
    {
        [tempsql appendString:[arrKeys objectAtIndex:i]];
        [tempsql appendString:@"=? "];
        if(i!=count-1)
        {
            [tempsql appendString:@"and "];
        }
    }
    
    return  [self.m_db executeUpdate:tempsql withArgumentsInArray:arrValues];;
}

#pragma mark - 更新满足所有条件的记录
-(BOOL)UpdateTableField:(NSDictionary*)dic condition:(NSDictionary*)dicCondtion tableName:(NSString*)name
{
    if([self NSStringIsNULL:name]) return NO;
    if(dicCondtion==nil || [dicCondtion count]==0) return NO;
    int count=(int)[dic count];
    if(dic==nil || count==0) return NO;
    NSArray * keyArray=[dic allKeys];
    NSString *sql = [NSString stringWithFormat:@"update %@ set ",name];
    NSMutableString * tempsql=[NSMutableString stringWithString:sql];
    
    for (int i=0; i<count; i++) {
        [tempsql appendString:[keyArray objectAtIndex:i]];
        [tempsql appendString:@"=?"];
        if(i != count-1)
        {
            [tempsql appendString:@", "];
        }
    }
    count=(int)[dicCondtion count];
    [tempsql appendString:@" where "];
    keyArray=[dicCondtion allKeys];
    for (int i=0; i<count; i++) {
        [tempsql appendString:[keyArray objectAtIndex:i]];
        [tempsql appendString:@"=?"];
        if(i != count-1)
        {
            [tempsql appendString:@" and "];
        }
    }
    
    NSMutableArray * valArray=[NSMutableArray arrayWithArray:[dic allValues]];
    NSArray *conditionValArray=[dicCondtion allValues];
    for(int i=0;i<[conditionValArray count];i++)
    {
        [valArray addObject:[conditionValArray objectAtIndex:i]];
    }
    
    [self.m_db executeUpdate:tempsql withArgumentsInArray:valArray];
   
    return YES;
}

- (BOOL) NSStringIsNULL:(NSString *)aStirng
{
    if(aStirng == nil) return YES;
    if ([aStirng length] == 0) return YES;
    if ([aStirng isKindOfClass:[NSNull class]])return YES;
    return NO;
}

@end


@implementation GoodsShonp_DB (goodshop_footprint)

- (BOOL)addFootprintInfoWtihDict:(NSDictionary *)dict{
    
    if (dict){
        
        NSMutableArray *array=[self getFootprintGoodsforMarkingInfoArrayforkey:dict[@"marking"]];
        
        if (array.count!=0) {
            
           GoodsShopModel *condict=[array firstObject];
           
            return  [self UpdateTableField:dict condition:[condict toDictionary] tableName:_name];
        }else{
            
            
            return   [self InsertIntoTableFieldDict:dict tableName:_name];
            
        }
        
    }else
        return NO;
}

- (NSMutableArray *)getFootprintInfoArray {
    
    FMResultSet *rs =  [self QueryIntoTableName:_name];
    
    NSMutableArray *array=[NSMutableArray array];
    //    NSDictionary *dict=[rs resultDictionary];
    //    NSLog(@"%@",dict);
    while ([rs next]) {
        
        
    }
    
    return array;
}


- (NSMutableArray *)getFootSpecsInfoArrayforkey:(NSString *)specid  andGooid:(NSString *)goodid storeid:(NSString *)storeid{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where specId='%@' and goodId='%@'  and storeid='%@'",_name,specid,goodid,storeid];
    
    FMResultSet *rs =  [self.m_db executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    
    while ([rs next]) {
        
        GoodsShopModel *model=[[GoodsShopModel alloc]init];
        
        model.storeid=[rs stringForColumn:@"storeid"];
        
        model.specId=[rs stringForColumn:@"specId"];
        model.goodId=[rs stringForColumn:@"goodId"];
        model.attributeId=[rs stringForColumn:@"attributeId"];
        model.goodnum=[rs stringForColumn:@"goodnum"];
        model.goodpick=[rs stringForColumn:@"goodpick"];
        model.goodprice=[rs stringForColumn:@"goodprice"];
        model.goodimg=[rs stringForColumn:@"goodimg"];
        model.goodname=[rs stringForColumn:@"goodname"];
        model.specname=[rs stringForColumn:@"specname"];
        model.specprice=[rs stringForColumn:@"specprice"];
        model.specpick=[rs stringForColumn:@"specpick"];
        model.atttip=[rs stringForColumn:@"atttip"];
        model.attributename=[rs stringForColumn:@"attributename"];
        model.marking=[rs stringForColumn:@"marking"];
        model.spec_tid=[rs stringForColumn:@"spec_tid"];
        model.gooddiscountprice=[rs stringForColumn:@"gooddiscountprice"];
        model.skillprice = [rs stringForColumn:@"skillprice"];
        model.is_skill = [rs stringForColumn:@"is_skill"];
        model.o_price = [rs stringForColumn:@"o_price"];
        
        [array addObject:model];
        
    }
    
    return array;
}

- (NSMutableArray *)getFootprintGoodsforAttriteInfoArrayforkey:(NSString *)goodid andstorid:(NSString *)storeid{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where goodId='%@' and storeid='%@'",_name,goodid,storeid];
    
    FMResultSet *rs =  [self.m_db executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    NSDictionary *dict=[rs resultDictionary];
    NSLog(@"%@",dict);
    
    while ([rs next]) {
        
        GoodsShopModel *model=[[GoodsShopModel alloc]init];        
        model.storeid=[rs stringForColumn:@"storeid"];
        model.specId=[rs stringForColumn:@"specId"];
        model.goodId=[rs stringForColumn:@"goodId"];
        model.attributeId=[rs stringForColumn:@"attributeId"];
        model.goodnum=[rs stringForColumn:@"goodnum"];
        model.goodpick=[rs stringForColumn:@"goodpick"];
        model.goodprice=[rs stringForColumn:@"goodprice"];
        model.goodimg=[rs stringForColumn:@"goodimg"];
        model.goodname=[rs stringForColumn:@"goodname"];
        model.specname=[rs stringForColumn:@"specname"];
        model.specprice=[rs stringForColumn:@"specprice"];
        model.specpick=[rs stringForColumn:@"specpick"];
        model.atttip=[rs stringForColumn:@"atttip"];
        model.attributename=[rs stringForColumn:@"attributename"];
        model.marking=[rs stringForColumn:@"marking"];
        model.spec_tid=[rs stringForColumn:@"spec_tid"];
        model.gooddiscountprice=[rs stringForColumn:@"gooddiscountprice"];
        model.skillprice = [rs stringForColumn:@"skillprice"];
        model.is_skill = [rs stringForColumn:@"is_skill"];
        model.o_price = [rs stringForColumn:@"o_price"];
        
        [array addObject:model];
    }
    
    return array;
}


- (NSMutableArray *)getFootprintGoodsforMarkingInfoArrayforkey:(NSString *)marking {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where marking='%@'",_name,marking];
    
    FMResultSet *rs =  [self.m_db executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    NSDictionary *dict=[rs resultDictionary];
    NSLog(@"%@",dict);
    
    while ([rs next]) {
        
        GoodsShopModel *model=[[GoodsShopModel alloc]init];
        
        model.storeid=[rs stringForColumn:@"storeid"];
        
        model.specId=[rs stringForColumn:@"specId"];
        model.goodId=[rs stringForColumn:@"goodId"];
        model.attributeId=[rs stringForColumn:@"attributeId"];
        model.goodnum=[rs stringForColumn:@"goodnum"];
        model.goodpick=[rs stringForColumn:@"goodpick"];
        model.goodprice=[rs stringForColumn:@"goodprice"];
        model.goodimg=[rs stringForColumn:@"goodimg"];
        model.goodname=[rs stringForColumn:@"goodname"];
        model.specname=[rs stringForColumn:@"specname"];
        model.specprice=[rs stringForColumn:@"specprice"];
        model.specpick=[rs stringForColumn:@"specpick"];
        model.atttip=[rs stringForColumn:@"atttip"];
        model.attributename=[rs stringForColumn:@"attributename"];
        model.marking=[rs stringForColumn:@"marking"];
        model.spec_tid=[rs stringForColumn:@"spec_tid"];
        model.gooddiscountprice=[rs stringForColumn:@"gooddiscountprice"];
        model.skillprice = [rs stringForColumn:@"skillprice"];
        model.is_skill = [rs stringForColumn:@"is_skill"];
        model.o_price = [rs stringForColumn:@"o_price"];
        
        [array addObject:model];
    }
    
    return array;
}


- (NSMutableArray *)getFootprintGoodsforstoreInfoArrayforkey:(NSString *)storeid {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where storeid='%@'",_name,storeid];
    
    FMResultSet *rs =  [self.m_db executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    NSDictionary *dict=[rs resultDictionary];
    NSLog(@"%@",dict);
    
    while ([rs next]) {
        
        GoodsShopModel *model=[[GoodsShopModel alloc]init];

        model.storeid=[rs stringForColumn:@"storeid"];
        model.specId=[rs stringForColumn:@"specId"];
        model.goodId=[rs stringForColumn:@"goodId"];
        model.attributeId=[rs stringForColumn:@"attributeId"];
        model.goodnum=[rs stringForColumn:@"goodnum"];
        model.goodpick=[rs stringForColumn:@"goodpick"];
        model.goodprice=[rs stringForColumn:@"goodprice"];
        model.goodimg=[rs stringForColumn:@"goodimg"];
        model.goodname=[rs stringForColumn:@"goodname"];
        model.specname=[rs stringForColumn:@"specname"];
        model.specprice=[rs stringForColumn:@"specprice"];
        model.specpick=[rs stringForColumn:@"specpick"];
        model.atttip=[rs stringForColumn:@"atttip"];
        model.attributename=[rs stringForColumn:@"attributename"];
        model.marking=[rs stringForColumn:@"marking"];
        model.spec_tid=[rs stringForColumn:@"spec_tid"];
        model.gooddiscountprice=[rs stringForColumn:@"gooddiscountprice"];
        model.skillprice = [rs stringForColumn:@"skillprice"];
        model.is_skill = [rs stringForColumn:@"is_skill"];
        model.o_price = [rs stringForColumn:@"o_price"];
        
        [array addObject:model];
    }
    
    return array;
}



- (NSMutableArray *)getFootprintSpecsforAttriteInfoArrayforkey:(NSString *)goodid  andSpecid:(NSString *)specid  AttributeName:(NSString *) attributename andAttinddex:(NSString *)index{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where goodId='%@' and specId='%@'  and  attributename='%@' and atttip='%@'",_name,goodid,specid,attributename,index];
    
    FMResultSet *rs =  [self.m_db executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    NSDictionary *dict=[rs resultDictionary];
    NSLog(@"%@",dict);
    while ([rs next]) {
        
        GoodsShopModel *model=[[GoodsShopModel alloc]init];
        
        model.storeid=[rs stringForColumn:@"storeid"];
        model.specId=[rs stringForColumn:@"specId"];
        model.goodId=[rs stringForColumn:@"goodId"];
        model.attributeId=[rs stringForColumn:@"attributeId"];
        model.goodnum=[rs stringForColumn:@"goodnum"];
        model.goodpick=[rs stringForColumn:@"goodpick"];
        model.goodprice=[rs stringForColumn:@"goodprice"];
        model.goodimg=[rs stringForColumn:@"goodimg"];
        model.goodname=[rs stringForColumn:@"goodname"];
        model.specname=[rs stringForColumn:@"specname"];
        model.specprice=[rs stringForColumn:@"specprice"];
        model.specpick=[rs stringForColumn:@"specpick"];
        model.atttip=[rs stringForColumn:@"atttip"];
        model.attributename=[rs stringForColumn:@"attributename"];
        model.marking=[rs stringForColumn:@"marking"];
        model.spec_tid=[rs stringForColumn:@"spec_tid"];
        model.gooddiscountprice=[rs stringForColumn:@"gooddiscountprice"];
        model.skillprice = [rs stringForColumn:@"skillprice"];
        model.is_skill = [rs stringForColumn:@"is_skill"];
        model.o_price = [rs stringForColumn:@"o_price"];
        
        [array addObject:model];
    }
    
    return array;
}



- (BOOL)deleteFootprintInfo:(GoodsShopModel *)info{
    
    if (info) {
        
        return  [self DeleteBycondition:[info toDictionary] tableName:_name];
    }return NO;
    
}

@end
