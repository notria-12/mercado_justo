import 'package:flutter/material.dart';

class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<List<T>> rowsCells;
  final Widget Function(T data) cellBuilder;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double headingHeight;
  final double cellMargin;
  final double cellSpacing;

  CustomDataTable(
      {required this.fixedCornerCell,
      required this.fixedColCells,
      required this.fixedRowCells,
      required this.rowsCells,
      required this.cellBuilder,
      this.fixedColWidth = 180,
      this.cellHeight = 56.0,
      this.cellWidth = 120.0,
      this.cellMargin = 10.0,
      this.cellSpacing = 10.0,
      this.headingHeight = 80});

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  Widget _buildChild(double width, T data, {bool isNotSubTable = false}) =>
      isNotSubTable
          ? SizedBox(
              width: width,
              child: data as Widget,
            )
          : SizedBox(
              width: width,
              child: widget.cellBuilder?.call(data) ?? Text('$data'));

  Widget _buildFixedCol() => widget.fixedColCells == null
      ? SizedBox.shrink()
      : Material(
          // color: Colors.lightBlueAccent,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.cellHeight,
              dataRowHeight: widget.cellHeight,
              columns: [
                DataColumn(
                    label: _buildChild(
                        widget.fixedColWidth, widget.fixedColCells.first))
              ],
              rows: widget.fixedColCells
                  .sublist(widget.fixedRowCells == null ? 1 : 0)
                  .map((c) => DataRow(cells: [
                        DataCell(_buildChild(widget.fixedColWidth, c,
                            isNotSubTable: true))
                      ]))
                  .toList()),
        );

  Widget _buildFixedRow() => widget.fixedRowCells == null
      ? SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.headingHeight,
              dataRowHeight: widget.cellHeight,
              columns: widget.fixedRowCells
                  .map((c) => DataColumn(
                      label: _buildChild(widget.cellWidth, c,
                          isNotSubTable: true)))
                  .toList(),
              rows: []),
        );

  Widget _buildSubTable() => Material(
      // color: Colors.lightGreenAccent,
      child: DataTable(
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: widget.cellHeight,
          dataRowHeight: widget.cellHeight,
          columns: widget.rowsCells.first
              .map((c) => DataColumn(label: _buildChild(widget.cellWidth, c)))
              .toList(),
          rows: widget.rowsCells
              .sublist(widget.fixedRowCells == null ? 1 : 0)
              .map((row) => DataRow(
                  cells: row
                      .map((c) => DataCell(_buildChild(widget.cellWidth, c)))
                      .toList()))
              .toList()));

  Widget _buildCornerCell() =>
      widget.fixedColCells == null || widget.fixedRowCells == null
          ? SizedBox.shrink()
          : Material(
              // color: Colors.amberAccent,
              child: DataTable(
                  horizontalMargin: widget.cellMargin,
                  columnSpacing: widget.cellSpacing,
                  headingRowHeight: widget.headingHeight,
                  dataRowHeight: widget.cellHeight,
                  columns: [
                    DataColumn(
                        label: _buildChild(
                            widget.fixedColWidth, widget.fixedCornerCell,
                            isNotSubTable: true))
                  ],
                  rows: []),
            );

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Row(
            children: <Widget>[
              SingleChildScrollView(
                controller: _columnController,
                scrollDirection: Axis.vertical,
                // controller: _subTableYController,
                // physics: NeverScrollableScrollPhysics(),
                child: _buildFixedCol(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  controller: _subTableXController,
                  scrollDirection: Axis.horizontal,
                  // child: SingleChildScrollView(
                  //   controller: _subTableYController,
                  //   scrollDirection: Axis.vertical,
                  child: _buildSubTable(),
                  // ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            _buildCornerCell(),
            Flexible(
              child: SingleChildScrollView(
                controller: _rowController,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: _buildFixedRow(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
