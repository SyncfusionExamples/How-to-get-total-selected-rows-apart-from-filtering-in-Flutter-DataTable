import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: const MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;
  DataGridController dataGridController = DataGridController();
  List<DataGridRow> selectedRows = [];

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

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

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData =
        employeeData
            .map<DataGridRow>(
              (e) => DataGridRow(
                cells: [
                  DataGridCell<int>(columnName: 'id', value: e.id),
                  DataGridCell<String>(columnName: 'name', value: e.name),
                  DataGridCell<String>(
                    columnName: 'designation',
                    value: e.designation,
                  ),
                  DataGridCell<int>(columnName: 'salary', value: e.salary),
                ],
              ),
            )
            .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((e) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            );
          }).toList(),
    );
  }
}
