//
//  __PDKTCoreDataEntityRelationshipOneToMany.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 07/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "__PDKTCoreDataEntityRelationshipOneToMany.h"

@implementation __PDKTCoreDataEntityRelationshipOneToMany
- (void)parseRelationshipInDictionary:(NSDictionary *)dictionary withEntity:(NSManagedObject *)entity relationshipProperty:(NSString *)relationshipProperty inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    id relationshipData = [dictionary valueForKeyPath:self.keyPath];
    if ([relationshipData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *relationshipItem in relationshipData) {
            id item = [self parseItemData:relationshipItem withClass:self.relatedClass inManagedObjectContext:managedObjectContext];
            if (item) {
                [self addItem:item toEntity:entity toColletionInPropertyWithName:relationshipProperty];
            }
        }
    }else{
        id item = [self parseItemData:relationshipData withClass:self.relatedClass inManagedObjectContext:managedObjectContext];
        if (item) {
            [entity setValue:item forKey:relationshipProperty];
        }
    }
}
- (id)parseItemData:(NSDictionary *)itemData withClass:(Class)itemClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [itemClass updateOrInsertIntoManagedObjectContext:managedObjectContext withDictionary:itemData];
}
- (void)addItem:(id)item toEntity:(NSManagedObject *)entity toColletionInPropertyWithName:(NSString *)relationshipPropertyName{
    NSString *addObjectsSelectorName = [NSString stringWithFormat:@"add%@:", [relationshipPropertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[relationshipPropertyName substringToIndex:1] capitalizedString]]];
    SEL addObjectsSelector = NSSelectorFromString(addObjectsSelectorName);
}
@end