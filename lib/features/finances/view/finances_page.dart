import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/finances_viewmodel.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/widgets/global_drawer.dart';
import '../../../shared/utils/greeting_utils.dart';
import '../../../core/router.dart';

class FinancesPage extends StatelessWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinancesViewModel(),
      child: Consumer<FinancesViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            drawer: const GlobalDrawer(),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    children: [
                      // Header with profile, greeting, and icons
                      _buildHeader(context),

                      SizedBox(height: 20.h),

                      // Financial summary cards
                      _buildFinancialSummaryCards(viewModel),

                      SizedBox(height: 20.h),

                      // Navigation tabs
                      _buildNavigationTabs(viewModel),

                      SizedBox(height: 20.h),

                      // Content based on selected tab
                      _buildTabContent(viewModel),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // Profile picture
          Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(AppConstants.profileImagePath),
          ),

          SizedBox(width: 16.w),

          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  GreetingUtils.getGreeting(),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16.sp,
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Name
                Text(
                  'Nicolas Smith',
                  style: GoogleFonts.greatVibes(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF424242),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Notification and menu icons
          Row(
            children: [
              GestureDetector(
                onTap: () => AppRouter.navigateToReminders(),
                child: Icon(
                  Icons.notifications_outlined,
                  size: 24.sp,
                  color: const Color(0xFF424242),
                ),
              ),
              SizedBox(width: 16.w),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 24.sp,
                    color: const Color(0xFF424242),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummaryCards(FinancesViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              title: 'Total Sales',
              amount: '\$${viewModel.totalSales.toStringAsFixed(2)}',
              subtitle: 'Gross revenue',
              icon: Icons.bar_chart,
              backgroundColor: const Color(0xFFE6FFF3),
              borderColor: const Color(0xFF75FFBC),

            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildSummaryCard(
              title: 'Total Expenses',
              amount: '\$${viewModel.totalExpenses.toStringAsFixed(2)}',
              subtitle: 'Operating costs',
              icon: Icons.money_off,
              backgroundColor: const Color(0xFFFFE1E1),
              borderColor: const Color(0xFFFF8181),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildSummaryCard(
              title: 'Booth Fees',
              amount: '\$${viewModel.boothFees.toStringAsFixed(2)}',
              subtitle: 'Event costs',
              icon: Icons.storefront,
              backgroundColor: const Color(0xFFFFF6DB),
              borderColor: const Color(0xFFFFDE7D),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildSummaryCard(
              title: 'Net Profit',
              amount: '\$${viewModel.netProfit.toStringAsFixed(2)}',
              subtitle: 'Profit margin',
              icon: Icons.account_balance_wallet,
              backgroundColor: const Color(0xFFEAEFFF),
              borderColor: const Color(0xFF80D0FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required String subtitle,
    required IconData icon,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    // Determine icon color based on card type
    Color iconColor;
    if (title == 'Total Sales') {
      iconColor = const Color(0xFF4CAF50);
    } else if (title == 'Total Expenses') {
      iconColor = const Color(0xFFE91E63);
    } else if (title == 'Booth Fees') {
      iconColor = const Color(0xFFFF9800);
    } else {
      iconColor = const Color(0xFF2196F3);
    }

    return Container(
      width: 77.w,
      height: 80.h,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Icon(icon, size: 16.sp, color: iconColor),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildNavigationTabs(FinancesViewModel viewModel) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 10.w),
  //     padding: EdgeInsets.all(8.w),
  //     height: 60.h, // Reduced height for horizontal layout
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFFFF8E1),
  //       borderRadius: BorderRadius.circular(16.r), // Match card border radius
  //       border: Border.all(
  //         color: const Color(0xFFF8BBD9),
  //         width: 1.w,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withValues(alpha: 0.05),
  //           blurRadius: 8.r,
  //           offset: Offset(0, 2.h),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: _buildTab(
  //             'Overview',
  //             Icons.grid_view,
  //             0,
  //             viewModel.selectedTabIndex == 0,
  //             () => viewModel.selectTab(0),
  //           ),
  //         ),
  //         SizedBox(width: 8.w),
  //         Expanded(
  //           child: _buildTab(
  //             'Booth Fees',
  //             Icons.storefront,
  //             1,
  //             viewModel.selectedTabIndex == 1,
  //             () => viewModel.selectTab(1),
  //           ),
  //         ),
  //         SizedBox(width: 8.w),
  //         Expanded(
  //           child: _buildTab(
  //             'Sales',
  //             Icons.trending_up,
  //             2,
  //             viewModel.selectedTabIndex == 2,
  //             () => viewModel.selectTab(2),
  //           ),
  //         ),
  //         SizedBox(width: 8.w),
  //         Expanded(
  //           child: _buildTab(
  //             'Expenses',
  //             Icons.account_balance_wallet,
  //             3,
  //             viewModel.selectedTabIndex == 3,
  //             () => viewModel.selectTab(3),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildTab(
  //   String title,
  //   IconData icon,
  //   int index,
  //   bool isSelected,
  //   VoidCallback onTap,
  // ) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
  //       decoration: BoxDecoration(
  //         color: isSelected ? const Color(0xFFFFF3C4) : Colors.white,
  //         borderRadius: BorderRadius.circular(16.r), // Match card border radius
  //         border: Border.all(
  //           color: isSelected ? const Color(0xFFFF8A00) : const Color(0xFFE0E0E0),
  //           width: 1.w,
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withValues(alpha: 0.05),
  //             blurRadius: 8.r,
  //             offset: Offset(0, 2.h),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             icon,
  //             size: 14.sp,
  //             color: isSelected ? const Color(0xFFFF8A00) : Colors.black,
  //           ),
  //           SizedBox(width: 6.w),
  //           Flexible(
  //             child: Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 11.sp,
  //                 fontWeight: FontWeight.w500,
  //                 color: isSelected ? const Color(0xFFFF8A00) : Colors.black,
  //               ),
  //               textAlign: TextAlign.center,
  //               overflow: TextOverflow.visible,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNavigationTabs(FinancesViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(8.w),
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8E8),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              'Overview',
              Icons.grid_view_rounded,
              0,
              viewModel.selectedTabIndex == 0,
                  () => viewModel.selectTab(0),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTab(
              'Booth Fees',
              Icons.storefront_outlined, // closer to screenshot
              1,
              viewModel.selectedTabIndex == 1,
                  () => viewModel.selectTab(1),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTab(
              'Sales',
              Icons.show_chart, // bar chart style
              2,
              viewModel.selectedTabIndex == 2,
                  () => viewModel.selectTab(2),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTab(
              'Expenses',
              Icons.attach_money, // cash icon
              3,
              viewModel.selectedTabIndex == 3,
                  () => viewModel.selectTab(3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      String title,
      IconData icon,
      int index,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFE58A) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected ? Colors.black : Colors.black87,
            ),
            SizedBox(width: 3.w),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(FinancesViewModel viewModel) {
    switch (viewModel.selectedTabIndex) {
      case 0:
        return _buildOverviewContent(viewModel);
      case 1:
        return _buildBoothFeesContent();
      case 2:
        return _buildSalesContent();
      case 3:
        return _buildExpensesContent();
      default:
        return _buildOverviewContent(viewModel);
    }
  }

  Widget _buildOverviewContent(FinancesViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Financial Overview
          Text(
            'Monthly Financial Overview',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF424242),
            ),
          ),

          SizedBox(height: 16.h),

          // Chart
          Container(
            height: 200.h,
            padding: EdgeInsets.all(16.w),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 200,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFE0E0E0).withValues(alpha: 0.5),
                      strokeWidth: 1.w,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.h,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('Jan', style: style);
                            break;
                          case 1:
                            text = const Text('Feb', style: style);
                            break;
                          case 2:
                            text = const Text('Mar', style: style);
                            break;
                          case 3:
                            text = const Text('Apr', style: style);
                            break;
                          case 4:
                            text = const Text('May', style: style);
                            break;
                          case 5:
                            text = const Text('Jun', style: style);
                            break;
                          case 6:
                            text = const Text('Jul', style: style);
                            break;
                          case 7:
                            text = const Text('Aug', style: style);
                            break;
                          case 8:
                            text = const Text('Sep', style: style);
                            break;
                          case 9:
                            text = const Text('Oct', style: style);
                            break;
                          case 10:
                            text = const Text('Nov', style: style);
                            break;
                          case 11:
                            text = const Text('Dec', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 200,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: const Color(0xFF757575),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        );
                      },
                      reservedSize: 40.w,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 900,
                lineBarsData: [
                  LineChartBarData(
                    spots: viewModel.getChartData(),
                    isCurved: true,
                    color: const Color(0xFF2E7D32), // Dark green line
                    barWidth: 3.w,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Get current month index (1–12) → convert to 0-based index
                        final currentMonthIndex = DateTime.now().month - 1;
                        if (index == currentMonthIndex) {
                          // Highlight the current month dot
                          return FlDotCirclePainter(
                            radius: 6.r,
                            color: Colors.black,
                            strokeWidth: 2.w,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 4.r,
                          color: const Color(0xFF2E7D32),
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: false, // Remove area fill to match design
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => const Color(0xFFFFE8E8),
                    tooltipBorder: BorderSide(
                      color: const Color(0xFFE0E0E0),
                      width: 1.w,
                    ),
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot.x;
                        final monthData = viewModel.monthlyData[flSpot.toInt()];
                        return LineTooltipItem(
                          '${monthData.month}\nSales : \$${monthData.sales.toStringAsFixed(2)}\nExpenses : \$${monthData.expenses.toStringAsFixed(2)}\nProfit : \$${monthData.profit.toStringAsFixed(2)}',
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Event History
          _buildEventHistory(viewModel),
        ],
      ),
    );
  }

  Widget _buildEventHistory(FinancesViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Event History',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF424242),
              ),
            ),
            GestureDetector(
              onTap: () => AppRouter.navigateToFinanceHistory(),
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFFF8A00),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Event cards
        Column(
          children: viewModel.eventHistory.map((event) {
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3C4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF424242),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          event.date,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            AppRouter.navigateToFinancesView(eventId: event.id),
                        child: Icon(
                          Icons.visibility,
                          size: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '\$${event.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBoothFeesContent() {
    return Consumer<FinancesViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Add Booth Fee',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF424242),
                ),
              ),

              SizedBox(height: 20.h),

              // Form Input Fields
              _buildInputField(
                icon: Icons.event,
                hintText: 'Enter Event',
                controller: viewModel.boothEventController,
                isRequired: true,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.calendar_today,
                hintText: 'Enter Date',
                controller: viewModel.boothDateController,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.aspect_ratio,
                hintText: 'Enter Booth Size',
                controller: viewModel.boothSizeController,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.storefront,
                hintText: 'Enter Booth Fee',
                controller: viewModel.boothFeeController,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20.h),

              // Add Booth Fee Button
              _buildActionButton(
                title: 'Add Booth Fee',
                icon: Icons.add,
                onTap: () {
                  final name = viewModel.boothEventController.text;
                  final size = viewModel.boothSizeController.text;
                  viewModel.addBoothFee(name:name, boothSize: size);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSalesContent() {
    return Consumer<FinancesViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Record Sale',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF424242),
                ),
              ),

              SizedBox(height: 20.h),

              // Form Input Fields
              _buildInputField(
                icon: Icons.event,
                hintText: 'Enter Event',
                controller: viewModel.salesEventController,
                isRequired: true,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.calendar_today,
                hintText: 'Enter Date',
                controller: viewModel.salesDateController,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.attach_money,
                hintText: 'Enter Gross sales',
                controller: viewModel.salesAmountController,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20.h),

              // Record Sale Button
              _buildActionButton(
                title: 'Record Sale',
                icon: Icons.shopping_bag,
                onTap: () {
                  viewModel.recordSale();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpensesContent() {
    return Consumer<FinancesViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Add Expenses',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF424242),
                ),
              ),

              SizedBox(height: 20.h),

              // Form Input Fields
              _buildInputField(
                icon: Icons.event,
                hintText: 'Enter Event',
                controller: viewModel.expensesEventController,
                isRequired: true,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.calendar_today,
                hintText: 'Enter Date',
                controller: viewModel.expensesDateController,
              ),

              SizedBox(height: 12.h),

              _buildInputField(
                icon: Icons.receipt,
                hintText: 'Enter Expenses',
                controller: viewModel.expensesAmountController,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20.h),

              // Add Expenses Button
              _buildActionButton(
                title: 'Add Expenses',
                icon: Icons.add_circle,
                onTap: () {
                  viewModel.addExpense();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool isRequired = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 48.h, // Fixed shorter height
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3C4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: 18.sp, color: const Color(0xFF424242)),
              if (isRequired)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Icon(
                    Icons.star,
                    size: 8.sp,
                    color: const Color(0xFFFF8A00),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF424242),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF757575),
                  height: 1.2,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A00), Color(0xFFFFC107)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
