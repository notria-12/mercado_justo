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
  final bool loadMore;
  final Widget? loadMoreWidget;

  VoidCallback? loadMoreColumns;

  CustomDataTable(
      {required this.loadMore,
      required this.fixedCornerCell,
      required this.fixedColCells,
      required this.fixedRowCells,
      required this.rowsCells,
      required this.cellBuilder,
      this.loadMoreWidget,
      this.loadMoreColumns,
      this.fixedColWidth = 90,
      this.cellHeight = 56.0,
      this.cellWidth = 100.0,
      this.cellMargin = 10.0,
      this.cellSpacing = 10.0,
      this.headingHeight = 60});

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();
  final _controller = ScrollController();

  Widget _buildChild(double width, T data, {bool isNotSubTable = false}) =>
      isNotSubTable
          ? SizedBox(
              width: width,
              child: data as Widget,
            )
          : SizedBox(width: width, child: data as Widget);

  Widget _buildFixedCol() => widget.fixedColCells == null
      ? SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              // border:
              //     TableBorder(right: BorderSide(color: Colors.grey, width: 1)),
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.headingHeight,
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
              border: TableBorder(
                  verticalInside: BorderSide(color: Colors.grey, width: 0.3)),
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
      color: Colors.white,
      child: DataTable(
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: widget.headingHeight,
          dataRowHeight: widget.cellHeight,
          border: TableBorder(
              verticalInside: BorderSide(color: Colors.grey, width: 0.3)),
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
              color: Colors.white,
              child: DataTable(
                  // border: TableBorder(
                  //     right: BorderSide(color: Colors.grey, width: 1)),
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

    // _rowController.addListener(() {
    //   if (_rowController.position.atEdge) {
    //     bool isTop = _rowController.position.pixels == 0;
    //     if (!isTop) {
    //       if (widget.loadMore) {
    //         widget.loadMoreColumns!();
    //       }
    //     }
    //   } else {}
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Row(
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
              Visibility(
                visible: widget.loadMore,
                child: widget.loadMoreWidget ?? Container(),
              )
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
            // Visibility(
            //   visible: widget.loadMore,
            //   child: InkWell(
            //     onTap: widget.loadMoreColumns,
            //     child: Container(
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           border: Border.all(color: Colors.blueAccent)),
            //       height: 40,
            //       child: Icon(
            //         Icons.add,
            //         color: Colors.blueAccent,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ],
    );
  }
}
