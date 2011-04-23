// CPTableViewAttributeInspector.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>

@implementation CPTableViewAttributeInspector : AKInspector {
    @outlet CPCheckBox          allowsColumnReordering;
    @outlet CPCheckBox          allowsColumnResizing;
    @outlet CPCheckBox          allowsColumnSelection;
    @outlet CPCheckBox          allowsEmptySelection;
    @outlet CPCheckBox          allowsMultipleSelection;
    @outlet CPCheckBox          usesAlternatingRowBackgroundColors;
    @outlet CPCheckBox          hiddenTableHeaders;
    @outlet CPTableView         tableColumnsTable;
    CPTableColumn               tableColumnsTableName;
    CPTableColumn               tableColumnsTableIdentifier;
    @outlet CPButton            tableColumnsAdd;
    @outlet CPButton            tableColumnsRemove;
    CPTableView                 tableView;
}

- (CPString)label {
    return @"Table View";
}

- (CPString)viewCibName {
    return @"CPTableViewAttributeInspector";
}

- (void)awakeFromCib {
    var cols = [tableColumnsTable tableColumns];
    tableColumnsTableName = cols[0];
    tableColumnsTableIdentifier = cols[1];

    [tableColumnsTable setDelegate:self];
    [tableColumnsTable setDataSource:self];    
}

- (void)refresh {
    var inspectedObjects = [self inspectedObjects];

    if ([inspectedObjects count] > 0) {
        tableView = inspectedObjects[0];
    }

    [allowsColumnReordering takeValueFromKeyPath:@"allowsColumnReordering" ofObjects:inspectedObjects];
    [allowsColumnResizing takeValueFromKeyPath:@"allowsColumnResizing" ofObjects:inspectedObjects];
    [allowsColumnSelection takeValueFromKeyPath:@"allowsColumnSelection" ofObjects:inspectedObjects];
    [allowsEmptySelection takeValueFromKeyPath:@"allowsEmptySelection" ofObjects:inspectedObjects];
    [allowsMultipleSelection takeValueFromKeyPath:@"allowsMultipleSelection" ofObjects:inspectedObjects];
    [usesAlternatingRowBackgroundColors takeValueFromKeyPath:@"usesAlternatingRowBackgroundColors" ofObjects:inspectedObjects];
    [hiddenTableHeaders takeValueFromKeyPath:@"headerView.hidden" ofObjects:inspectedObjects];

    [tableColumnsTable reloadData];
}

- (@action)takeAllowsColumnReorderingFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setAllowsColumnReordering:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeAllowsColumnResizingFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setAllowsColumnResizing:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeAllowsColumnSelectionFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setAllowsColumnSelection:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeAllowsEmptySelectionFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setAllowsEmptySelection:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeAllowsMultipleSelectionFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setAllowsMultipleSelection:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeUsesAlternatingRowBackgroundColorsFrom:(id)aCheckBox {
    [[self inspectedObjects] makeObjectsPerformSelector:@selector(setUsesAlternatingRowBackgroundColors:) withObject:[aCheckBox intValue]];
    [tableView display];
}

- (@action)takeHiddenTableHeadersFrom:(id)aCheckBox {
    [[tableView headerView] setHidden:[aCheckBox intValue]];
    [tableView display];
}


- (@action)addTableColumn:(id)aSender {
    var cols = [tableView tableColumns];
    var identifier = "" + cols.length;
    var name = "Column " + identifier;

    var col = [[CPTableColumn alloc] initWithIdentifier:identifier];
    [[col headerView] setStringValue:name];
    [[col headerView] sizeToFit];
    [tableView addTableColumn:col];

    [tableColumnsTable reloadData];
    [tableView display];
}

- (@action)removeTableColumn:(id)aSender {
    var rowIndex = [tableColumnsTable selectedRow];
    var cols = [tableView tableColumns];

    if (rowIndex < 0) {
        return;
    }
    var tableColumn = cols[rowIndex];

    [tableView removeTableColumn:tableColumn];

    [tableColumnsTable reloadData];
    [tableView display];
}

@end

@implementation CPTableViewAttributeInspector (CPTableView)

- (int)numberOfRowsInTableView:(CPTableView)aTableView {
    return [tableView numberOfColumns];
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex {
    var cols = [tableView tableColumns];
    if (aTableColumn == tableColumnsTableName) {
        return [[cols[rowIndex] headerView] stringValue];
    } else if (aTableColumn == tableColumnsTableIdentifier) {
        return [cols[rowIndex] identifier];
    }
    return '-';
}

- (void)tableView:(CPTableView)aTableView setObjectValue: (CPControl)anObject forTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex {
    var cols = [tableView tableColumns];

    if (aTableColumn == tableColumnsTableName) {
        [[cols[rowIndex] headerView] setStringValue:anObject];
    } else if (aTableColumn == tableColumnsTableIdentifier) {
        [cols[rowIndex] setIdentifier:anObject];
    }
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification {
    var rowIndex = [tableColumnsTable selectedRow];
    [tableColumnsRemove setEnabled:(rowIndex >= 0)];
}


@end
