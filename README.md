# How to get total selected rows apart from filtering in Flutter DataTable (SfDataGrid)?

In this article, we will show you how to get total selected rows apart from filtering in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) with the necessary properties. Maintain a flag list to track selected rows. Use the [onSelectionChanged](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/onSelectionChanged.html) event to add or remove rows from this list as they are selected or deselected. This callback is triggered after a row is selected. By accessing the list, you can retrieve the total number of selected rows, even after filtering.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion Flutter DataGrid')),
      body: Column(
        children: [
          TextButton(
            child: const Text('Total selected rows'),
            onPressed: () {
              // Get total selected rows by accessing the flag list.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Selected Rows'),
                    content: Text(
                      'Total selected rows: ${selectedRows.length}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Expanded(
            child: SfDataGrid(
              controller: dataGridController,
              source: employeeDataSource,
              allowFiltering: true,
              selectionMode: SelectionMode.multiple,
              columnWidthMode: ColumnWidthMode.fill,
              onSelectionChanged: (addedRows, removedRows) {
                // Add rows if not already in selectedRows.
                selectedRows.addAll(
                  addedRows.where((row) => !selectedRows.contains(row)),
                );

                // Remove rows if they exist in selectedRows.
                selectedRows.removeWhere((row) => removedRows.contains(row));
              },
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'id',
                  label: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text('ID'),
                  ),
                ),
                GridColumn(
                  columnName: 'name',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Name'),
                  ),
                ),
                GridColumn(
                  columnName: 'designation',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Designation',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'salary',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Salary'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
```

You can download this example on [GitHub](https://github.com/SyncfusionExamples/How-to-get-total-selected-rows-apart-from-filtering-in-Flutter-DataTable).